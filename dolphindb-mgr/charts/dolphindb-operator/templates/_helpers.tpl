{{- define "dolphindbOperator.fullName" -}}
{{- default "dolphindb-operator" .Values.nameOverride -}}
{{- end -}}

{{- define "dolphindbOperator.imageTag" -}}
{{- default .Values.global.version .Values.imageTag -}}
{{- end -}}