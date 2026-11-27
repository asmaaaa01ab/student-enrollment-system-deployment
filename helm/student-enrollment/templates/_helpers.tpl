{{/* Étiquettes communes. Appel : include "student-enrollment.labels" (dict "name" $name) */}}
{{- define "student-enrollment.labels" -}}
app: {{ .name }}
app.kubernetes.io/part-of: student-enrollment
{{- end }}

{{/* Nom complet de l'image : [registre/]prefixe/image:tag */}}
{{- define "student-enrollment.image" -}}
{{- $g := .root.Values.global -}}
{{- $img := .svc.image | default .name -}}
{{- $tag := .svc.tag | default $g.imageTag -}}
{{- if $g.imageRegistry -}}
{{ $g.imageRegistry }}/{{ $g.imagePrefix }}/{{ $img }}:{{ $tag }}
{{- else -}}
{{ $g.imagePrefix }}/{{ $img }}:{{ $tag }}
{{- end -}}
{{- end }}
