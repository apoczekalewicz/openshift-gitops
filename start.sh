oc apply -f bootstrap/gitops/gitops-operator.yaml
read A
PLAN=$(oc get installplan -A | grep openshift-gitops-operator | awk '{print $2}')
oc patch installplan $PLAN --namespace openshift-operators --type merge --patch '{"spec":{"approved":true}}'
read A
oc apply -k bootstrap/default/
read A
echo "oc edit cm argocd-rbac-cm -n openshift-gitops # change policy.default to ''"
