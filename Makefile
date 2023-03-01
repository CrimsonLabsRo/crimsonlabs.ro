include .env

install-minify:
	curl https://wilsonl.in/minify-html/bin/0.10.8-linux-x86_64 -o minify-html
	chmod +x minify-html

minify:
	./minify-html --output index.html --keep-closing-tags --minify-css index.dev.html

pack:
	zip -0 deploy.zip favicon.ico index.html

validate-aws-app-id:
	aws amplify get-app --app-id $(AWS_AMPLIFY_APP_ID)

deploy-init:
	aws amplify create-deployment --app-id $(AWS_AMPLIFY_APP_ID) --branch-name prod > job.json

deploy-upload-files:
	curl "$(shell cat job.json | jq -r .zipUploadUrl)" -H "Content-Type: application/zip" -T deploy.zip

deploy-start:
	aws amplify start-deployment --app-id $(AWS_AMPLIFY_APP_ID) --branch-name prod --job-id $(shell cat job.json | jq -r .jobId)

deploy:
	make minify && make pack && make deploy-init && make deploy-upload-files && make deploy-start

deploy-status:
	aws amplify get-job --app-id $(AWS_AMPLIFY_APP_ID) --branch-name prod --job-id $(shell cat job.json | jq -r .jobId)

deploy-clean:
	rm index.html deploy.zip job.json