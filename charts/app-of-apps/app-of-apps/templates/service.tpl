{{- define "service" -}}
{{ $appName := .child -}}
---
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: {{ .root.env }}-service-{{ $appName }}
spec:
  destination:
    namespace: demo
    server: https://kubernetes.default.svc
  project: default
  source:
    path: charts/service
    helm:
      version: v3
      parameters:
      - name: env
        value: {{ .root.env }}
      valueFiles:
        - ../../overrides/service/{{ $appName }}/base.yaml
        - ../../overrides/service/{{ .child }}/{{ .root.env }}.yaml
  syncPolicy:
    automated: {}
{{ end }}