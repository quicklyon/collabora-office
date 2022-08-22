<!-- 该文档是模板生成，手动修改的内容会被覆盖，详情参见：https://github.com/quicklyon/template-toolkit -->
# QuickOn Collabora-Office 应用镜像

[![GitHub Workflow Status](https://github.com/quicklyon/collabora-office-docker/actions/workflows/docker.yml/badge.svg)](https://github.com/quicklyon/collabora-office/actions/workflows/docker.yml)
![Docker Pulls](https://img.shields.io/docker/pulls/easysoft/collabora-office?style=flat-square)
![Docker Image Size](https://img.shields.io/docker/image-size/easysoft/collabora-office?style=flat-square)
![GitHub tag](https://img.shields.io/github/v/tag/quicklyon/collabora-office-docker?style=flat-square)

> 申明: 该软件镜像是由QuickOn打包。在发行中提及的各自商标由各自的公司或个人所有，使用它们并不意味着任何从属关系。

## 快速参考

- 通过 [渠成软件百宝箱](https://www.qucheng.com/app-install/install-collabora-office-145.html) 一键安装 **Collabora-Office**
- [Dockerfile 源码](https://github.com/quicklyon/collabora-office-docker)
- [Collabora-Office 源码](https://github.com/CollaboraOnline/online)
- [Collabora-Office 官网](https://www.collaboraoffice.com/)

## 一、关于 Collabora-Office

<!-- 这里写应用的【介绍信息】 -->

**Collabora Office**是一个开源的在线办公套件，可以集成到任何 Web 应用程序中，它由 Collabora 的一个部门 Collabora Productivity开发。Collabora Online 以LibreOffice为核心，它可以对文字处理文档、电子表格、演示文稿和矢量图形进行协作式实时编辑。

Collabora 是 LibreOffice 的上级组织[The Document Foundation](https://www.wikiwand.com/en/The_Document_Foundation) (TDF) 的商业合作伙伴。TDF 指出，大部分 LibreOffice 软件开发是由其商业合作伙伴 Collabora、[Red Hat](https://www.wikiwand.com/en/Red_Hat)、CIB 和 Allotropia 完成的。

![screenshots](https://raw.githubusercontent.com/quicklyon/collabora-office-docker/master/.template/screenshot.png)

Collabora-Office官网：[https://www.collaboraoffice.com/](https://www.collaboraoffice.com/)

<!-- 这里写应用的【附加信息】 -->
### 1.1 特性

任何现代网络浏览器都可以访问 Collabora office 进行实时编辑或协作编辑；文本文档、电子表格、演示文稿和矢量图形。

协作功能包括多人评论与回复，支持文档比较和恢复等文档版本历史记录的功能。高级协作功能包括在协作编辑文档的同时集成视频通话或聊天等功能， Collabora Office 提供了企业文件同步和共享的在线解决方案（可以与[禅道](https://www.zentao.net/book/zentaobizhelp/267.html)、[Nextcloud](https://www.wikiwand.com/en/Nextcloud)、[ownCloud](https://www.wikiwand.com/en/OwnCloud)、[Seafile](https://www.wikiwand.com/en/Seafile)和[EGroupware](https://www.wikiwand.com/en/EGroupware) 集成）。

## 二、支持的版本(Tag)

由于版本比较多,这里只列出最新的5个版本,更详细的版本列表请参考:[可用版本列表](https://hub.docker.com/r/easysoft/collabora-office/tags/)

<!-- 这里是应用的【Tag】信息，通过命令维护，详情参考：https://github.com/quicklyon/template-toolkit -->
- [latest](https://github.com/quicklyon/collabora-office/releases/tag/v20220819)
- [22.05.5.3.1-20220819](https://github.com/quicklyon/collabora-office/releases/tag/v20220819)
- [6.4.14.3-20220819](https://github.com/quicklyon/collabora-office/releases/tag/v20220819)

## 三、获取镜像

推荐从 [Docker Hub Registry](https://hub.docker.com/r/easysoft/collabora-office) 拉取我们构建好的官方Docker镜像。

```bash
docker pull easysoft/collabora-office:latest
```

如需使用指定的版本,可以拉取一个包含版本标签的镜像,在Docker Hub仓库中查看 [可用版本列表](https://hub.docker.com/r/easysoft/collabora-office/tags/)

```bash
docker pull easysoft/collabora-office:[TAG]
```

##  四、运行

### 4.1 单机Docker-compose方式运行

通过docker-compose会运行禅道、mysql和collabora-office三个服务，查看[禅道配置文档预览的说明文档](https://www.zentao.net/book/zentaobizhelp/267.html)。

```bash
# 启动服务
make run

# 查看服务状态
make ps

# 查看服务日志
docker-compose logs -f collabora-office

```
**说明:**

- [VERSION](https://github.com/quicklyon/collabora-office-docker/blob/master/VERSION) 文件中详细的定义了Makefile可以操作的版本
- [docker-compose.yml](https://github.com/quicklyon/collabora-office-docker/blob/master/docker-compose.yml)
<!-- 这里写应用的【make命令的备注信息】位于文档最后端 -->

## 五、版本升级

容器镜像已为版本升级做了特殊处理，当检测数据（数据库/持久化文件）版本与镜像内运行的程序版本不一致时，会进行数据库结构的检查，并自动进行数据库升级操作。

因此，升级版本只需要更换镜像版本号即可：

> 修改 docker-compose.yml 文件

```diff
...
  collabora-office:
-    image: easysoft/collabora-office:6.4.14.3-20220818
+    image: easysoft/collabora-office:6.4.14.3-20220820
    container_name: collabora-office
...
```

更新服务

```bash
# 是用新版本镜像更新服务
docker-compose up -d

# 查看服务状态和镜像版本
docker-compose ps
```