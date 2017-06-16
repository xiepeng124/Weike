//
//  APIConfig.h
//  WeiKe
//
//  Created by 谢鹏 on 2017/4/5.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#ifndef APIConfig_h
#define APIConfig_h
//服务器地址
#define SERVER_IP @"http://192.168.1.151:8080/wksys"
//首页广告
#define HOME_AD @"http://192.168.1.151:8080/wksys/index/app/indexPage"
//最新视频
#define NEW_VIDEO @"http://192.168.1.151:8080/wksys/index/app/isNewVideo"
//最热视频
#define HOT_VIDEO @"http://192.168.1.151:8080/wksys/index/app/isHotVideo"
//
#define SEARCH_VIDEO @"http://192.168.1.151:8080/wksys/index/app/searchVideo"

                              /*微课堂*/
//学段接口
#define WEI_Grade @"http://192.168.1.151:8080/wksys/app/wxy/loadGrade"
//课程接口
#define WEI_COURSE @"http://192.168.1.151:8080/wksys/app/wxy/loadCourse"
//获取条件视频
#define WEI_VEDIO @"http://192.168.1.151:8080/wksys/app/wxy/loadVideoList"

                             //教师专栏
//所有教师
#define ALL_TEACHER @"http://192.168.1.151:8080/wksys/app/teaCol/loadTeaList"

#define MY_TEACHER @"http://192.168.1.151:8080/wksys/app/myInfo/myTeaVideo"

#define TEACHER_LIST @"http://192.168.1.151:8080/wksys/app/teaCol/loadTeaVideoList"
                            /*视频播放和评论*/
//视频获取
#define VIDEO_PLAY @"http://192.168.1.151:8080/wksys/app/video/play"
//视频播放记录次数
#define VIDEO_PLAY_COUNT @"http://192.168.1.151:8080/wksys/app/video/saveTime"
//视频评论获取
#define VIDEO_COMMENT @"http://192.168.1.151:8080/wksys/app/message/comment/loadCommentList"
//视频根评论
#define VIDEO_COMMENT_SEND @"http://192.168.1.151:8080/wksys/app/message/comment/addRootComment"
//视频子评论
#define VIDEO_REPLY_SEND @"http://192.168.1.151:8080/wksys/app/message/comment/addChildComment"
                            /*后台管理*/
//角色搜索
#define ROLE_SEARCH @"http://192.168.1.151:8080/wksys/app/sys/role/query"
//添加角色
#define ROLE_ADD @"http://192.168.1.151:8080/wksys/app/sys/role/create"
//角色编辑
#define ROLE_EDIT @"http://192.168.1.151:8080/wksys/app/sys/role/modify"
//角色删除
#define ROLE_DELETE @"http://192.168.1.151:8080/wksys/app/sys/role/delete"
//批量删除
#define ROLE_DELETE_MORE @"http://192.168.1.151:8080/wksys/app/sys/role/deleteMore"
//已绑定
#define ROLE_BIND_YES @"http://192.168.1.151:8080/wksys/app/sys/role/bUsersQuery"
//单个解绑
#define ROLE_BIND_UN @"http://192.168.1.151:8080/wksys/app/sys/role/unbRoleUser"
//多个解绑
#define ROLE_BIND_UNMORE @"http://192.168.1.151:8080/wksys/app/sys/role/unbRoleMoreUser"
//未绑定
#define ROLE_BIND_NO @"http://192.168.1.151:8080/wksys/app/sys/role/unbUserQuery"
//绑定
#define ROLE_BIND @"http://192.168.1.151:8080/wksys/app/sys/role/bRoleUser"

//视频
#define Video_Search @"http://192.168.1.151:8080/wksys/app/video/info/query"
//批量删除视频
#define Video_DELETE @"http://192.168.1.151:8080/wksys/app/video/info/deleteList"
//批量设置分类
#define VIEDO_SET @"http://192.168.1.151:8080/wksys/app/video/info/batchSetType"
//判断广告页
#define VIEDO_AD @"http://192.168.1.151:8080/wksys/app/video/info/isUploadAd"
//广告页上传
#define VIEDO_AD_UP @"http://192.168.1.151:8080/wksys/app/video/info/uploadAd"
//广告页保存
#define VIEDO_AD_CREATE @"http://192.168.1.151:8080/wksys/app/video/info/createAd"
//撤销发布
#define VIEDO_CANCEL @"http://192.168.1.151:8080/wksys/app/video/info/cancelPublish"
//撤销广告页
#define VIEDO_AD_CANCEL @"http://192.168.1.151:8080/wksys/app/video/info/cancelAd"
//封面上传
#define VIEDO_COVER @"http://192.168.1.151:8080/wksys/app/video/info/coverUpload"
//合并视频
#define VIEDO_MERGE @"http://192.168.1.151:8080/wksys/app/video/info/toConcatFlag"
//合并视频创建
#define VIEDO_MERGE_CREATE @"http://192.168.1.151:8080/wksys/app/video/info/concatFlag"
//上传视频
#define VIEDO_UPLOAD @"http://192.168.1.151:8080/wksys/app/video/info/upload"
//上传外部视频保存
#define VIEDO_OUTLINK @"http://192.168.1.151:8080/wksys/app/video/info/createOut"
//视频编辑
#define VIEDO_EDIT @"http://192.168.1.151:8080/wksys/app/video/info/toUpdate"
//视频编辑保存
#define VIEDO_EDIT_KEEP @"http://192.168.1.151:8080/wksys/app/video/info/updateLocal"
//视频上传保存
#define VIEDO_UPLOAD_KEEP  @"http://192.168.1.151:8080/wksys/app/video/info/createLocal"

//待审批
#define NOTAPPROVAL_VIEDO  @"http://192.168.1.151:8080/wksys/app/video/audit/queryWaitAudit"
//审批
#define APPROVALING_VIEDO  @"http://192.168.1.151:8080/wksys/app/video/audit/createAudit"
//已审批
#define APPROVALED_VIEDO @"http://192.168.1.151:8080/wksys/app/video/audit/queryEndAudit"
//指标查询
#define INDICATOR_SEARCH @"http://192.168.1.151:8080/wksys/app/video/reward/query"
//指标保存
#define INDICATOR_KEEP @"http://192.168.1.151:8080/wksys/app/video/reward/setReward"

//老师作业查询
#define JOB_SEARCH  @"http://192.168.1.151:8080/wksys/app/task/taskInfo/query"
//作业编辑
#define JOB_EDIT  @"http://192.168.1.151:8080/wksys/app/task/taskInfo/update"
//作业删除
#define JOB_DELETE @"http://192.168.1.151:8080/wksys/app/task/taskInfo/delete"
//作业上传
#define JOB_UPLOAD @"http://192.168.1.151:8080/wksys/app/task/taskInfo/uploadFile"
//
#define JOB_SELECTED_CLASS @"http://192.168.1.151:8080/wksys/app/task/taskInfo/loadGradeAndClass"

#define JOB_ADD @"http://192.168.1.151:8080/wksys/app/task/taskInfo/create"
//作业评分数据
#define JOB_SCORE_EDIT @"http://192.168.1.151:8080/wksys/app/task/taskInfo/toTaskScore"
//已交学生数据
#define JOB_SEND_STU @"http://192.168.1.151:8080/wksys/app/task/taskInfo/queryTaskScore"
//作业评分
#define JOB_SCORE @"http://192.168.1.151:8080/wksys/app/task/taskInfo/saveTaskScore"
//作业分享
#define JOB_SHARE @"http://192.168.1.151:8080/wksys/app/task/taskInfo/saveShareTask"
              /*个人中心 */
//学生上交查询
#define JOB_HAND_SEARCH @"http://192.168.1.151:8080/wksys/app/task/stuTaskDelivery/handTaskQuery"
//上交作业
#define JOB_HAND @"http://192.168.1.151:8080/wksys/app/task/stuTaskDelivery/handInTask"
//作业查看
#define JOB_WATCH @"http://192.168.1.151:8080/wksys/app/task/stuTaskDelivery/queryStuTask"
//观看记录
#define WATCH_RECORD @"http://192.168.1.151:8080/wksys/app/video/watchHistory"
//我的数据
#define MY_DATA @"http://192.168.1.151:8080/wksys/app/myInfo/perData"
//我的头像
#define MY_HEAD @"http://192.168.1.151:8080/wksys/app/myInfo/fileUpload"
//保存个人资料
#define MY_DATA_KEEP @"http://192.168.1.151:8080/wksys/app/myInfo/modifyPerData"
//密码修改
#define MY_PASSWORD @"http://192.168.1.151:8080/wksys/app/myInfo/modifyPsd"


//视频统计管理
//查询
#define VIDEO_STATIST @"http://192.168.1.151:8080/wksys/app/video/statistics/query"
//对应教师视频
#define VIDEO_STATIST_TEACHER @"http://192.168.1.151:8080/wksys/app/video/statistics/queryTeaVideo"



#endif /* APIConfig_h */
