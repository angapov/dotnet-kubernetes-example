{{- define "kubernetes.name" -}}
{{- .Release.Name | trunc 63 | replace "_" "-" | trimSuffix "-" }}
{{- end }}

{{- define "kubernetes.labels" -}}
app.kubernetes.io/name: {{ include "kubernetes.name" . }}
{{- end }}

{{- define "kubernetes.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "kubernetes.name" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{- define "kubernetes.env" -}}
{{- if and .Values.env (kindIs "slice" .Values.env) }}
{{- range .Values.env -}}
- name: {{ .name }}
  value: {{ tpl .value $ }}
{{- end }}
{{- end }}
{{- end }}
