{{- define "grafana.pod" -}}
{{- if .Values.schedulerName }}
schedulerName: "{{ .Values.schedulerName }}"
{{- end }}
{{- if .Values.securityContext }}
securityContext:
{{ toYaml .Values.securityContext | indent 2 }}
{{- end }}
containers:
  - name: {{ .Chart.Name }}
    image: {{ include "repository" . }}/grafana:{{ .Values.image.tag }}
    imagePullPolicy: {{ .Values.image.pullPolicy }}
  {{- if .Values.command }}
    command:
    {{- range .Values.command }}
      - {{ . }}
    {{- end }}
  {{- end}}
    volumeMounts:
      - name: config
        mountPath: "/etc/grafana/grafana.ini"
        subPath: grafana.ini
      - name: storage
        mountPath: "/var/lib/grafana"
      - name: config
        mountPath: "/etc/grafana/provisioning/datasources/datasources.yaml"
        subPath: datasources.yaml
      - name: config
        mountPath: "/etc/grafana/provisioning/dashboards/dashboards.yaml"
        subPath: dashboards.yaml
      - mountPath: /var/lib/grafana/dashboards
        name: dashboards
      - mountPath: /etc/localtime
        name: localtime
    ports:
      - name: {{ .Values.service.portName }}
        containerPort: {{ .Values.service.port }}
        protocol: TCP
      - name: {{ .Values.podPortName }}
        containerPort: 3000
        protocol: TCP
    env:
      - name: GF_PATHS_DATA
        value: {{ (get .Values "grafana.ini").paths.data }}
      - name: GF_PATHS_LOGS
        value: {{ (get .Values "grafana.ini").paths.logs }}
      - name: GF_PATHS_PLUGINS
        value: {{ (get .Values "grafana.ini").paths.plugins }}
      - name: GF_PATHS_PROVISIONING
        value: {{ (get .Values "grafana.ini").paths.provisioning }}
    livenessProbe:
{{ toYaml .Values.livenessProbe | indent 6 }}
    readinessProbe:
{{ toYaml .Values.readinessProbe | indent 6 }}
{{- with .Values.nodeSelector }}
nodeSelector:
{{ toYaml . | indent 2 }}
{{- end }}
{{- with .Values.affinity }}
affinity:
{{ toYaml . | indent 2 }}
{{- end }}
{{- with .Values.tolerations }}
tolerations:
{{ toYaml . | indent 2 }}
{{- end }}
volumes:
  - name: config
    configMap:
      name: {{ template "grafana.fullname" . }}
  - name: storage
    emptyDir: {}
  - name: dashboards
    configMap:
      name: grafana-dashboards
  {{- include "mgr.localtime.volume" . | indent 2}}
{{- end }}
