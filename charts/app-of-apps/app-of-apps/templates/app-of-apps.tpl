{{- define "app-of-apps" -}}
---
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: {{ .child }}
spec:
  destination:
    namespace: demo
    server: https://kubernetes.default.svc
  project: default
  source:
    repoURL: https://github.com/argoproj/argocd-example-apps.git
    targetRevision: HEAD

    path: charts/app-of-apps
    helm:
      parameters:
        - name: renderBaseDir
          value: {{ .root.renderBaseDir }}
{{- with .root.parameters }}
{{ . | toYaml | indent 8 }}
{{- end }}
{{ .childParams.parameters | toYaml | indent 8 }}
      valueFiles:
        - ../../overrides/app-of-apps/{{ .child }}.yaml

  syncPolicy:
    automated: {}
{{ end }}