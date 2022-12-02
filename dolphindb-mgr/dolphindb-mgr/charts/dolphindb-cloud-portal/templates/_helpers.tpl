{{- define "dolphindbCloudPortal.fullName" -}}
{{- default "dolphindb-cloud-portal" .Values.nameOverride -}}
{{- end -}}

{{- define "dolphindbCloudPortal.imageTag" -}}
{{- default .Values.global.version .Values.imageTag -}}
{{- end -}}

{{- define "dolphindbCloudPortal.service.type" -}}
{{- default .Values.serviceType  (include "global.service.type" .) -}}
{{- end -}}