{{- define "pod.template" }}
    metadata:
      labels:
        app.kubernetes.io/name: {{ include "seafile.name" . }}
        app.kubernetes.io/instance: {{ .Release.Name }}
    spec:
      volumes:
      {{- with .Values.volumes }}
      {{- toYaml . | nindent 6 }}
      {{- end }}
      containers:
      - name: seafile-mysql
        image: {{ .Values.db.image }}
        imagePullPolicy: Always
        volumeMounts:
        {{- with .Values.db.volumeMounts }}
        {{- toYaml . | nindent 8 }}
        {{- end }}
        env:
{{ toYaml .Values.db.environment | indent 8 }}
      - name: seafile-memcached
        image: {{ .Values.memcached.image }}
        imagePullPolicy: Always
        command: ["memcached"]
        args: ["-m", "256"]
        ports:
        - name: memcached
          containerPort: 11211
          protocol: TCP
      - name: seafile
        image: {{ .Values.seafile.image }}
        imagePullPolicy: Always
        volumeMounts:
        {{- with .Values.seafile.volumeMounts }}
        {{- toYaml . | nindent 8 }}
        {{- end }}
        env:
{{ toYaml .Values.seafile.environment | indent 8 }}
        ports:
        - name: http
          containerPort: 80
          protocol: TCP
{{- end -}}