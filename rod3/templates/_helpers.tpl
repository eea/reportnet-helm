{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "rod3.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "rod3.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "rod3.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "rod3.labels" -}}
helm.sh/chart: {{ include "rod3.chart" . }}
{{ include "rod3.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "rod3.selectorLabels" -}}
app.kubernetes.io/name: {{ include "rod3.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "rod3.serviceAccountName" -}}
{{- if .Values.serviceAccount.create -}}
    {{ default (include "rod3.fullname" .) .Values.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.serviceAccount.name }}
{{- end -}}
{{- end -}}

{{/* ------------------------------- MARIADB helpers ------------ */}}

{{- define "mariadb.name" -}}
{{- default .Chart.Name .Values.mariadb.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "mariadb.fullname" -}}
{{- if .Values.mariadb.fullnameOverride -}}
{{- .Values.mariadb.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.mariadb.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- printf .Release.Name | trunc 60 | trimSuffix "-" -}}-db
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 60 | trimSuffix "-" -}}-db
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Return the name of the Secret used to store the passwords
*/}}
{{- define "mariadb.secretName" -}}
{{- if .Values.existingSecret -}}
{{ .Values.existingSecret }}
{{- else -}}
{{ template "mariadb.fullname" . -}}
{{- end -}}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "mariadb.labels" -}}
helm.sh/chart: {{ include "rod3.chart" . }}
{{ include "rod3.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "mariadb.selectorLabels" -}}
app.kubernetes.io/name: {{ include "mariadb.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}-db
{{- end -}}
