{{- define "dolphindbWebserver.fullName" -}}
{{- default "dolphindb-webserver" .Values.nameOverride -}}
{{- end -}}

{{- define "dolphindbWebserver.imageTag" -}}
{{- default .Values.global.version .Values.imageTag -}}
{{- end -}}