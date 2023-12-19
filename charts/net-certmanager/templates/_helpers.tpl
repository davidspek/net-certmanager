{{/*
Expand the name of the chart.
*/}}
{{- define "net-certmanager.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "net-certmanager.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "net-certmanager.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "net-certmanager.labels" -}}
helm.sh/chart: {{ include "net-certmanager.chart" . }}
{{ include "net-certmanager.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
networking.knative.dev/certificate-provider: cert-manager
{{- end }}

{{/*
Selector labels
*/}}
{{- define "net-certmanager.selectorLabels" -}}
app.kubernetes.io/name: {{ include "net-certmanager.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/component: net-certmanager
{{- end }}


{{/*
Controller Selector labels
*/}}
{{- define "net-certmanager.controllerSelectorLabels" -}}
app: net-certmanager-controller
{{- end }}

{{/*
Webhook Selector labels
*/}}
{{- define "net-certmanager.webhookSelectorLabels" -}}
app: net-certmanager-webhook
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "net-certmanager.serviceAccountName" -}}
{{- default "controller" .Values.serviceAccount.name }}
{{- end }}
