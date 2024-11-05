# 数据风险地图

#### 项目介绍
在数字化转型的浪潮中，数据已成为企业最宝贵的资产之一。数据资产风险地图工具，是一款旨在简化数据安全合规工作的强大软件。它能够帮助企业和个人更好地理解、管理和降低数据风险，确保数据的安全性和合规性。这款工具在数据安全治理和合规方面，提供适合数据安全合规业务场景的效率工具。
![数据风险地图](/.images/数据风险地图.jpg)



添加微信 ` faint100` 备注 dsp 进群

> 不允许非法项目使用，后果自负。

![添加微信](/.images/wx-faint100.png)


#### 开源说明
本项目于 2024 年 11 月 1 日在 Gitee 上开源，我们希望通过开源社区的力量，共同完善和发展这款工具，为数据安全领域做出贡献。
欢迎广大开发者参与贡献代码、提出问题和建议，让我们一起打造更强大的数据风险地图工具！

#### 主要功能
1. 数据资产分布：自动发现数据资产，统筹管理结构化数据；
2. 风险可视化：以直观的地图形式展示数据风险分布，让你一目了然地了解潜在风险；
3. 合规辅助：提供数据安全合规的指导和建议，帮助你轻松满足法规要求。
4. 实时监测：持续监控数据风险变化，及时发出提醒，让你能够迅速采取应对措施；
5. 自定义设置：可根据不同的需求和场景进行个性化设置，满足各种数据安全管理要求。

#### 系统模块

```
data-risk-map
├── drm-framework                      // 项目框架
│ ├── drm-common                       // 公共模块
│ ├── drm-module-system-api            // 系统API
│ ├── drm-starter-biz-data-permission // 数据权限
│ ├── drm-starter-biz-ip 
│ ├── drm-starter-excel
│ ├── drm-starter-job
│ ├── drm-starter-mq                // 集成消息队列
│ ├── drm-starter-mybatis           // 集成 mybatis
│ ├── drm-starter-protection        // 服务保护，提供分布式锁、幂等、限流..
│ ├── drm-starter-redis             // 集成 redis
│ ├── drm-starter-rpc 
│ ├── drm-starter-security       // 集成 spring-security
│ └── drm-starter-web           // web 服务
├── drm-gateway                 // 网关
├── drm-module-dmap             // 业务模块：数据风险地图服务
│ ├── drm-module-dmap-api 
│ └── drm-module-dmap-biz
├── drm-module-system          // 业务模块：系统服务
│ └── drm-module-system-biz
├── drm-parent                // 顶级依赖
└── drm-ui-admin-vue3         // 前端代码
```

#### 软件架构
软件架构说明

#### 安装教程

##### 快速启动-后端

1. 依赖环境

   java8、mysql、redis、nacos、rocketmq

2. 拉取代码

3. 执行 SQL 脚本

   - 创建 drm-system-free 数据库，导入 drm_system_free.sql 数据库文件，文件路径 ./drm-module-system/drm-module-system-biz/sql/drm-system-free.sql
   - 创建 drm-dmap-free 数据库，导入 drm_dmap_free.sql 数据库文件，文件路径 ./drm-module-dmap/drm-module-dmap-biz/sql/drm_map_free.sql

4. 启动中间件

   如果有redis环境，可以直接忽略，如果没有，请安装：
   Linux版本：https://redis.io/download
   Windows版本：https://github.com/microsoftarchive/redis/releases



启动 nacos，如果没有请安装：https://nacos.io/

启动 nacos 服务后，创建命名空间 drm-local

![image-20241104155501379](/.images/image-20241104155501379.png)

5. 修改后端配置

   项目默认启动环境为 local，所以进行 local 环境的配置，修改三个业务模块的 application-local.yaml 文件

   修改 nacos 的服务地址和口令

   ![image-20241104160615420](/.images/image-20241104160615420.png)

   修改 redis 的连接地址

   ![image-20241104155938912](/.images/image-20241104155938912.png)

   修改数据库的连接信息

   ![image-20241104160024800](/.images/image-20241104160024800.png)

6. 启动后端服务

   项目是扁平化结构，多服务部署，在执行打包时请按照顺序进行打包，先 drm-parent，后 drm-framework ，其他业务模块不分先后。

   ```
   data-risk-map
   ├── drm-parent          // 顶级依赖
   ├── drm-framework       // 基础依赖包
   ├── drm-gateway         // 业务模块：网关
   ├── drm-module-dmap     // 业务模块：数据风险地图服务
   └── drm-module-system // 业务模块：系统服务
   ```

##### 快速启动-前端

首先需准备 node.js 环境。

1. 导入前端代码 drm-ui-admin-vue3 ，修改后端服务地址

   ![image-20241104160814019](/.images/image-20241104160814019.png)

2. 启动服务

前端是 Vue3 管理后台项目，拉取代码后在根目录执行如下命令，进行启动：

```bash
# 安装 pnpm，提升依赖的安装速度
npm config set registry https://registry.npmmirror.com
npm install -g pnpm
# 安装依赖
pnpm install

# 启动服务
npm run dev
```

![image-20241104162815862](/.images/image-20241104162815862.png)

#### 使用说明

待补充

#### 参与贡献

1.  如果你发现了 bug 或者有功能需求，可以通过以下方式提出：

- 在 Gitee 项目页面提交 issue。
- 发送邮件至：[项目邮箱地址]。


2.  如果你想贡献代码，可以按照以下步骤进行：

- Fork 本项目到你的 Gitee 仓库。
- 在你的本地仓库进行开发和测试。
- 提交 pull request，说明你的修改内容和目的。

我们将及时审核你的贡献，并在合并后向你表示感谢。