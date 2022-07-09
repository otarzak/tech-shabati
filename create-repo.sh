#! /bin/sh
repoName=$1

while [ -z "$repoName" ]
do
    echo 'Provide a repository name'
    read -r -p $'Repository name:' repoName
done

echo "# $repoName" >> README.md
git init
git add .
git commit -m "First commit"

curl https://api.github.com/user/repos -H "Accept: application/vnd.github+json" -H "Authorization: token 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" -d '{"name": "'"$repoName"'", "private":false}'


GIT_URL=$(curl -H "Accept: application/vnd.github.v3+json" https://api.github.com/repos/otarzak/"$repoName" | jq -r '.clone_url')

git branch -M master
git remote add origin $GIT_URL
git push -u origin master
