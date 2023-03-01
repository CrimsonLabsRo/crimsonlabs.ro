# CrimsonLabs.ro

Static website hosted on AWS Amplify | [crimsonlabs.ro](https://crimsonlabs.ro)

### Update content:
1. Make changes in `index.dev.html`.

### Deploy:
1. Create `.env` file (copy `.env.dist`);
2. Add Amplify app id from AWS in `.env` file; test if it is correctly added in the env file using `make validate-aws-app-id`;
3. Install `minify-html` with `make install-minify`;
4. Run `make deploy`.
