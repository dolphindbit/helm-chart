{{- define "work.namespace" -}}
    {{ if .Values.global.allNamespace }}
    {{- printf "all" -}}
    {{- else -}}
    {{- printf "%s" .Release.Namespace -}}
    {{- end -}}
{{- end -}}

{{- define "global.service.type" -}}
{{- default "NodePort" .Values.global.serviceType -}}
{{- end -}}

{{- define "dolphindb.service.type" -}}
{{- default (include "global.service.type" .) .Values.dolphindb.serviceType -}}
{{- end -}}

{{- define "dolphindb-init.default.tag" -}}
{{- default .Values.global.version .Values.dolphindb.images.default.dolphindbInit -}}
{{- end -}}

{{- define "dolphindb-partner.default.tag" -}}
{{- default .Values.global.version .Values.dolphindb.images.default.dolphindbPartner -}}
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
