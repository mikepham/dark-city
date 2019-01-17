"""
rancher-deprovision.py 

This script calls home to the Rancher control cluster and causes it to deprovision this container host.

Usage:  
    rancher-provision.py (--rancherurl=<u>) (--accesskey=<a>) (--secretkey=<s>) (--project=<p>)

Options:  
    -u --rancherurl=<u> URL of the rancher control server/ELB
    -a --accesskey=<a>  Rancher Access Key
    -s --secretkey=<s>  Rancher Secret Key
    -p --project=<p>    Project ID of your rancher environment
    -h --help           display this help text
"""

import requests
import json
import sys
import socket
import os
import traceback
import time from requests.auth
import HTTPBasicAuth from docopt
import docopt from create_pagerduty_incident
import trigger_incident

PD_OPSLOW_INTKEY = "1901u0a902304890509180948109480918a"

# Path for a file laid down by the amibuilder ansible job. This file should not
# exist on a live box, as it is laid down on ephemeral volume by amibuilder

amibuilderfile = "/mnt/tmp/amibuilder.txt"
instance_type_path = "instance-type"


class TooManyMatches(Exception):
    pass


class NoMatches(Exception):
    pass


class FailureInPostAction(Exception):
    pass


def get_hostname():
    return socket.gethostname()


def post_request_to_rancher(rancher_url, project_id, host_id, action, desiredstate, auth):
    resp = requests.post(
        "{}/v1/projects/{}/hosts/{}/?action={}".format(
            rancher_url, project_id, host_id, action
        ), auth=auth)
    if resp.status_code == 202:
        i = 0
        while i <= 6:
            state = get_rancher_host_state(
                rancher_url, project_id, host_id, desiredstate, auth
            )
            if state == desiredstate:
                return True
            else:
                time.sleep(5)
                i += 1
        return False
    else:
        raise FailureInPostAction("Action: {} - Non-202 Response Code: {}".format(
            action, resp.status_code
        )
        )


def get_rancher_host_state(rancher_url, project_id, host_id, desiredstate, auth):
    return requests.get(
        "{}/v1/projects/{}/hosts/{}".format(rancher_url, project_id, host_id),
        auth=auth).json()['state']


def get_rancher_host_id(rancher_url, project_id, local_hostname, auth):
    resp = requests.get(
        "{}/v1/projects/{}/hosts/".format(
            rancher_url, project_id
        ), auth=auth).json()
    if resp['data']:
        matches = []
        for h in resp['data']:
            if h['hostname'] == local_hostname:
                matches.append(h['id'])
        if len(matches) > 1:
            raise TooManyMatches("More than one match for hostname: {}".format(
                local_hostname
            )
            )
        elif len(matches) == 0:
            raise NoMatches(
                "No hosts found matching {}".format(local_hostname))
        else:
            return str(matches[0])


if __name__ == '__main__':
    if os.path.isfile(amibuilderfile):
        sys.exit(0)
    arguments = docopt(__doc__)
    accesskey = arguments["--accesskey"]
    secretkey = arguments["--secretkey"]
    rancherurl = arguments["--rancherurl"]
    projectid = arguments["--project"]
    hostname = get_hostname()
    auth = HTTPBasicAuth(accesskey, secretkey)

    try:
        host_id = get_rancher_host_id(rancherurl, projectid, hostname, auth)

        deactivate = post_request_to_rancher(
            rancherurl, projectid, host_id, "deactivate", "inactive", auth
        )
        if deactivate:
            remove = post_request_to_rancher(
                rancherurl, projectid, host_id, "remove", "removed", auth
            )
            if remove:
                purge = post_request_to_rancher(
                    rancherurl, projectid, host_id, "purge", "purged", auth
                )

    except (FailureInPostAction, NoMatches, TooManyMatches) as e:
        trigger_incident(
            PD_OPSLOW_INTKEY, repr(e)
        )

    except Exception as e:
        trigger_incident(
            PD_OPSLOW_INTKEY,
            "Encountered Exception while removing {} from {}: {}".format(
                hostname, rancherurl, repr(e)
            )
        )
