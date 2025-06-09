
Resourses from the `download-list.yml` file will be automatically downloaded into `resources/[local]/[autodownload]`

Use the `download-list.yml` file as follows:
- Use the preferred resource name as a key
- Use the resource's ZIP download link as a value (redirects will be followed)
- If the resource exists within a folder in the ZIP, add `#` and the folder name after the URL

After this is done, other files in this folder will be used to replace files in the same path under `resources/[local]/[autodownload]`
