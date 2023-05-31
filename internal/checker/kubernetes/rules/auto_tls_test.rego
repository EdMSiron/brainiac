package lib.kubernetes.CB_K8S_085

test_auto_tls_passed {
    result := passed with input as input_data("false")
	count(result) == 1
}

test_auto_tls_failed {
    result := failed with input as input_data(argument)
	count(result) == 1
}

input_data(args) = patch {
    patch := json.patch(json_data, [{ "op": "replace", "path": "spec/containers/0/command/1", "value": concat("=", [flag, args]) }])
}

json_data := {
                "apiVersion": "v1",
                "kind": "Pod",
                "metadata": {
                    "creationTimestamp": null,
                    "labels": {
                    "component": "kubelet",
                    "tier": "control-plane"
                    },
                    "name": "kubelet",
                    "namespace": "kube-system"
                },
                "spec": {
                    "containers": [
                    {
                        "command": [
                        "etcd",
                        "replaceable_data"
                        ],
                        "image": "gcr.io/google_containers/kubelet-amd64:v1.6.0",
                        "name": "gcr"
                    }
                    ]
                }
            }