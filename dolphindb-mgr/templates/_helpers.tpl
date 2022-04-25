{{- define "work.namespace" -}}
    {{ if .Values.global.allNamespace }}
    {{- printf "all" -}}
    {{- else -}}
    {{- printf "%s" .Release.Namespace -}}
    {{- end -}}
{{- end -}}

{{- define "global.serviceaccount.name" -}}
{{- printf "%s-%s" .Values.global.serviceAccount ( include "work.namespace" .) -}}
{{- end -}}

{{- define "global.service.type" -}}
{{- default "NodePort" .Values.global.serviceType -}}
{{- end -}}

{{- define "dolphindb.service.type" -}}
{{- default (include "global.service.type" .) .Values.dolphindb.serviceType -}}
{{- end -}}

{{- define "dolphindb-config-loader.default.tag" -}}
{{- default .Values.global.version .Values.dolphindb.images.default.dolphindbConfigLoader -}}
{{- end -}}

{{- define "dolphindb-service-manager.default.tag" -}}
{{- default .Values.global.version .Values.dolphindb.images.default.dolphindbServiceManager -}}
{{- end -}}

{{- define "dolphindb-exporter.default.tag" -}}
{{- default .Values.global.version .Values.dolphindb.images.default.dolphindbExporter -}}
{{- end -}}

{{- define "dolphindb-cleaner.default.tag" -}}
{{- default .Values.global.version .Values.dolphindb.images.default.dolphindbCleaner -}}
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

{{- define "localtime.filehostpath" -}}
{{- default "/etc/localtime" .Values.global.localTimeFileHostPath -}}
{{- end -}}

{{- define "mgr.localtime.volume" }}
- hostPath:
    path: {{ include "localtime.filehostpath" . }}
  name: localtime
{{- end }}
