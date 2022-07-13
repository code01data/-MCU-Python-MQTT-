# git上传文件的基本命令
1. 把这个目录变成git可以管理的仓库：

git init

2. 关联到远程库：

git remote add origin git@ 服务器地址

3. 获取远程库与本地同步合并:

git pull --rebase origin master

4. 添加到暂存区里面去，如果后面接小数点“.”，意为添加文件夹下的所有文件：

git add 文件名

5. 把文件提交到仓库。引号内为提交说明：

git commit -m  '相关说明'

6. 将最新的修改推送到远程仓库：

git push -u origin master

7. 查看改动情况:

git status

8. 查看在哪个位置:

git branch

9. 切换到分支:

git checkout 分支名

10. 上传到服务器:

git push 服务器名 分支名

11. 获取git服务器上的文件：

git clone  仓库的路径

12. 删除远程文件

git rm -r --cached 文件名   #--cached不会把本地的文件删除
git commit -m 'delete  dir'
git push -u origin master

13. 删除远程仓库命令：
如果远程仓库信息有误，则删除本地仓库配置，并且设置相关地址
git remote rm 远程仓库名称
