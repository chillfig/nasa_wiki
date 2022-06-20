#!/bin/sh
cfs_repos=(cfs cfe osal psp sch_lab ci_lab to_lab sample_app sample_lib elf2cfetbl tblcrctool cFS-GroundSystem cf cs ds fm hk hs lc md mm sc)
rm -rf prs.json
for repo in $cfs_repos
do
gh pr list --repo nasa/$repo --search label:CCB:Ready --json number,author,title,url | jq -c 'reduce range(0, length) as $index (.; (.[$index].author=.[$index].author.login | .[$index].number=(.[$index].number|"'$repo' PR #\(.)") )) ' >> prs.json
done
jq -r -n '[ inputs[] ] | unique_by(."author") | .[].author' prs.json #get author list