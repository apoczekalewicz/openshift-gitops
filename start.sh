oc apply -f bootstrap/gitops/gitops-operator.yaml
read A
echo Click Enter for approval install-plan
PLAN=$(oc get installplan -A | grep openshift-gitops-operator | awk '{print $2}')
oc patch installplan $PLAN --namespace openshift-operators --type merge --patch '{"spec":{"approved":true}}'
echo Click Enter for bootstrap cluster 
read A
oc apply -k bootstrap/default/
read A
echo "oc edit cm argocd-rbac-cm -n openshift-gitops # change policy.default to ''"

# i usunac z instancji argocd
#   resource.exclusions: |
#    - apiGroups:
#      - tekton.dev
#      clusters:
#      - '*'
#      kinds:
#      - TaskRun
#      - PipelineRun

