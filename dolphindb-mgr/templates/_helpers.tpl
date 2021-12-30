{{- define "work.namespace" -}}
    {{ if .Values.global.allNamespace }}
    {{- printf "all" -}}
    {{- else -}}
    {{- printf "%s" .Release.Namespace -}}
    {{- end -}}
{{- end -}}

{{- define "rbac.role.kind" -}}
    {{ if .Values.global.allNamespace }}
    {{- printf "ClusterRole" -}}
    {{- else -}}
    {{- printf "Role" -}}
    {{- end -}}
{{- end -}}

{{- define "rbac.roleBinding.kind" -}}
    {{ if .Values.global.allNamespace }}
    {{- printf "ClusterRoleBinding" -}}
    {{- else -}}
    {{- printf "RoleBinding" -}}
    {{- end -}}
{{- end -}}

{{- define "repository" -}}
{{- $registry := .Values.global.registry -}}
    {{ if $registry }}
    {{- printf "%s/%s" $registry .Values.global.repository -}}
    {{- else -}}
    {{- printf "%s" .Values.global.repository -}}
    {{- end -}}
{{- end -}}

{{- define "mgr.env" }}
- name: Namespace
  valueFrom:
    fieldRef:
      fieldPath: metadata.namespace
- name: WorkNamespace
  value: {{ include "work.namespace" . }}
{{- end }}
