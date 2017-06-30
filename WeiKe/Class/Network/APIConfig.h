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
//#define SERVER_IP @"http://39.108.174.172"
//登录
#define SERVER_LOGIN [SERVER_IP stringByAppendingString:@"/index/app/login/"]
//首页广告
#define HOME_AD  [SERVER_IP stringByAppendingString:@"/index/app/indexPage"]



//最新视频
#define NEW_VIDEO [SERVER_IP stringByAppendingString:@"/index/app/isNewVideo"]
//最热视频
#define HOT_VIDEO [SERVER_IP stringByAppendingString:@"/index/app/isHotVideo"]

//
#define SEARCH_VIDEO [SERVER_IP stringByAppendingString:@"/index/app/searchVideo"]

                             /*消息中心*/
//所有消息未读
#define MESSAGE_NO [SERVER_IP stringByAppendingString:@"/app/message/msg/loadNotReadMsgSize"]

//消息列表
#define MESSAGE_LIST [SERVER_IP stringByAppendingString:@"/app/message/msg/loadMsgList"]

//消息删除
#define MESSAGE_DELETE [SERVER_IP stringByAppendingString:@"/app/message/msg/delete"]
//消息标记已读
#define MESSAGE_SAW [SERVER_IP stringByAppendingString:@"/app/message/msg/signAllRead"]
//评论列表
#define MESSAGE_COMMENT [SERVER_IP stringByAppendingString:@"/app/message/msg/initCommentList"]
//删除评论
#define MESSAGE_COMMENT_DELETE [SERVER_IP stringByAppendingString:@"/app/message/comment/delete"]
//回复评论
#define MESSAGE_COMMENT_REPLY [SERVER_IP stringByAppendingString:@"/app/message/comment/addReplyComment"]
//查看作业分享
#define MESSAGE_TASK_SHARE [SERVER_IP stringByAppendingString:@"/app/task/taskInfo/lookShareTask"]



                              /*微课堂*/
//学段接口
#define WEI_Grade [SERVER_IP stringByAppendingString:@"/app/wxy/loadGrade"]
//课程接口
#define WEI_COURSE [SERVER_IP stringByAppendingString:@"/app/wxy/loadCourse"]
//获取条件视频
#define WEI_VEDIO [SERVER_IP stringByAppendingString:@"/app/wxy/loadVideoList"]

                             //教师专栏
//所有教师
#define ALL_TEACHER [SERVER_IP stringByAppendingString:@"/app/teaCol/loadTeaList"]

#define MY_TEACHER [SERVER_IP stringByAppendingString:@"/app/myInfo/myTeaVideo"]

#define TEACHER_LIST [SERVER_IP stringByAppendingString:@"/app/teaCol/loadTeaVideoList"]

                  /*视频播放和评论*/
//视频获取
#define VIDEO_PLAY [SERVER_IP stringByAppendingString:@"/app/video/play"]
//视频播放记录次数
#define VIDEO_PLAY_COUNT [SERVER_IP stringByAppendingString:@"/app/video/saveTime"]
//视频评论获取
#define VIDEO_COMMENT [SERVER_IP stringByAppendingString:@"/app/message/comment/loadCommentList"]
//视频根评论
#define VIDEO_COMMENT_SEND [SERVER_IP stringByAppendingString:@"/app/message/comment/addRootComment"]
//视频子评论
#define VIDEO_REPLY_SEND [SERVER_IP stringByAppendingString:@"/app/message/comment/addChildComment"]

                      /*后台管理*/
//角色搜索
#define ROLE_SEARCH [SERVER_IP stringByAppendingString:@"/app/sys/role/query"]

//添加角色
#define ROLE_ADD [SERVER_IP stringByAppendingString:@"/app/sys/role/create"]
//角色编辑
#define ROLE_EDIT [SERVER_IP stringByAppendingString:@"/app/sys/role/modify"]
//角色删除
#define ROLE_DELETE [SERVER_IP stringByAppendingString:@"/app/sys/role/delete"]

//批量删除
#define ROLE_DELETE_MORE [SERVER_IP stringByAppendingString:@"/app/sys/role/deleteMore"]

//已绑定
#define ROLE_BIND_YES [SERVER_IP stringByAppendingString:@"/app/sys/role/bUsersQuery"]

//单个解绑
#define ROLE_BIND_UN [SERVER_IP stringByAppendingString:@"/app/sys/role/unbRoleUser"]

//多个解绑
#define ROLE_BIND_UNMORE [SERVER_IP stringByAppendingString:@"/app/sys/role/unbRoleMoreUser"]

//未绑定
#define ROLE_BIND_NO [SERVER_IP stringByAppendingString:@"/app/sys/role/unbUserQuery"]

//绑定
#define ROLE_BIND [SERVER_IP stringByAppendingString:@"/app/sys/role/bRoleUser"]
//角色授权
#define ROLE_AUTHOR [SERVER_IP stringByAppendingString:@"/app/sys/role/loadMenuBtu"]
#define ROLE_AUTHOR_KEEP [SERVER_IP stringByAppendingString:@"/app/sys/role/bindMenuBtu"]

     //视频
#define Video_Search [SERVER_IP stringByAppendingString:@"/app/video/info/query"]
//批量删除视频
#define Video_DELETE [SERVER_IP stringByAppendingString:@"/app/video/info/deleteList"]

//批量设置分类
#define VIEDO_SET [SERVER_IP stringByAppendingString:@"/app/video/info/batchSetType"]
//判断广告页
#define VIEDO_AD [SERVER_IP stringByAppendingString:@"/app/video/info/isUploadAd"]
//广告页上传
#define VIEDO_AD_UP [SERVER_IP stringByAppendingString:@"/app/video/info/uploadAd"]
//广告页保存
#define VIEDO_AD_CREATE [SERVER_IP stringByAppendingString:@"app/video/info/createAd"]
//撤销发布
#define VIEDO_CANCEL [SERVER_IP stringByAppendingString:@"/app/video/info/cancelPublish"]
//撤销广告页
#define VIEDO_AD_CANCEL [SERVER_IP stringByAppendingString:@"/app/video/info/cancelAd"]
//封面上传
#define VIEDO_COVER [SERVER_IP stringByAppendingString:@"/app/video/info/coverUpload"]
//合并视频
#define VIEDO_MERGE [SERVER_IP stringByAppendingString:@"/app/video/info/toConcatFlag"]
//合并视频创建
#define VIEDO_MERGE_CREATE [SERVER_IP stringByAppendingString:@"/app/video/info/concatFlag"]
//上传视频
#define VIEDO_UPLOAD [SERVER_IP stringByAppendingString:@"/app/video/info/upload"]
//上传外部视频保存
#define VIEDO_OUTLINK [SERVER_IP stringByAppendingString:@"/app/video/info/createOut"]
//视频编辑
#define VIEDO_EDIT [SERVER_IP stringByAppendingString:@"/app/video/info/toUpdate"]
//视频编辑保存
#define VIEDO_EDIT_KEEP [SERVER_IP stringByAppendingString:@"/app/video/info/updateLocal"]
//视频上传保存
#define VIEDO_UPLOAD_KEEP  [SERVER_IP stringByAppendingString:@"/app/video/info/createLocal"]

//待审批
#define NOTAPPROVAL_VIEDO  [SERVER_IP stringByAppendingString:@"/app/video/audit/queryWaitAudit"]
//审批
#define APPROVALING_VIEDO  [SERVER_IP stringByAppendingString:@"/app/video/audit/createAudit"]
//已审批
#define APPROVALED_VIEDO [SERVER_IP stringByAppendingString:@"/app/video/audit/queryEndAudit"]
//指标查询
#define INDICATOR_SEARCH [SERVER_IP stringByAppendingString:@"/app/video/reward/query"]
//指标保存
#define INDICATOR_KEEP [SERVER_IP stringByAppendingString:@"/app/video/reward/setReward"]

//老师作业查询
#define JOB_SEARCH  [SERVER_IP stringByAppendingString:@"/app/task/taskInfo/query"]
//作业编辑
#define JOB_EDIT  [SERVER_IP stringByAppendingString:@"/app/task/taskInfo/update"]
//作业删除
#define JOB_DELETE [SERVER_IP stringByAppendingString:@"/app/task/taskInfo/delete"]
//作业上传
#define JOB_UPLOAD [SERVER_IP stringByAppendingString:@"/app/task/taskInfo/uploadFile"]
//
#define JOB_SELECTED_CLASS [SERVER_IP stringByAppendingString:@"/app/task/taskInfo/loadGradeAndClass"]

#define JOB_ADD [SERVER_IP stringByAppendingString:@"/app/task/taskInfo/create"]
//作业评分数据
#define JOB_SCORE_EDIT [SERVER_IP stringByAppendingString:@"/app/task/taskInfo/toTaskScore"]
//已交学生数据
#define JOB_SEND_STU [SERVER_IP stringByAppendingString:@"/app/task/taskInfo/queryTaskScore"]
//作业评分
#define JOB_SCORE [SERVER_IP stringByAppendingString:@"/app/task/taskInfo/saveTaskScore"]
//作业分享
#define JOB_SHARE [SERVER_IP stringByAppendingString:@"/app/task/taskInfo/saveShareTask"]
//老师作业查看
#define JOB_TEACH_WATCH [SERVER_IP stringByAppendingString:@"/app/task/taskInfo/showTask"]

   //用户管理
//用户数据列表
#define USER_LIST [SERVER_IP stringByAppendingString:@"/app/sys/user/userManage/query"]
//用户禁用
#define USER_FORBID [SERVER_IP stringByAppendingString:@"/app/sys/user/userManage/disable"]
//用户启用
#define USER_START [SERVER_IP stringByAppendingString:@"/app/sys/user/userManage/able"]
//教师信息编辑
#define USER_TEACHER [SERVER_IP stringByAppendingString:@"/app/sys/user/userManage/teaEdit"]
//学生信息编辑
#define USER_STUDENT [SERVER_IP stringByAppendingString:@"/app/sys/user/userManage/stuEdit"]
//密码修改
#define USER_PASSWORD_SET [SERVER_IP stringByAppendingString:@"/app/sys/user/userManage/passwdEdit"]
//用户角色绑定
#define USER_ROLE_SET [SERVER_IP stringByAppendingString:@"/app/sys/user/userManage/roleQuery"]
//角色提交
#define USER_ROLE_UP [SERVER_IP stringByAppendingString:@"/app/sys/user/userManage/bindRoleUser"]

///档案管理
//教师档案查询
#define ARCHIVES_TEA [SERVER_IP stringByAppendingString:@"/app/sys/teacher/query"]
//教师档案删除
#define ARCHIVES_TEA_DELETE [SERVER_IP stringByAppendingString:@"/app/sys/teacher/deletes"]
//教师档案详情
#define ARCHIVES_TEA_DETAIL [SERVER_IP stringByAppendingString:@"/app/sys/teacher/detail"]
//学生档案查询
#define ARCHIVES_STU [SERVER_IP stringByAppendingString:@"/app/sys/student/query"]
//学生档案删除
#define ARCHIVES_STU_DELETE [SERVER_IP stringByAppendingString:@"/app/sys/student/deletes"]





              /*个人中心 */
//学生上交查询
#define JOB_HAND_SEARCH [SERVER_IP stringByAppendingString:@"/app/task/stuTaskDelivery/handTaskQuery"]
//上交作业
#define JOB_HAND [SERVER_IP stringByAppendingString:@"/app/task/stuTaskDelivery/handInTask"]
//作业查看
#define JOB_WATCH [SERVER_IP stringByAppendingString:@"/app/task/stuTaskDelivery/queryStuTask"]
//观看记录
#define WATCH_RECORD [SERVER_IP stringByAppendingString:@"/app/video/watchHistory"]
//我的数据
#define MY_DATA [SERVER_IP stringByAppendingString:@"/app/myInfo/perData"]
//我的头像
#define MY_HEAD [SERVER_IP stringByAppendingString:@"/app/myInfo/fileUpload"]
//保存个人资料
#define MY_DATA_KEEP [SERVER_IP stringByAppendingString:@"/app/myInfo/modifyPerData"]
//密码修改
#define MY_PASSWORD [SERVER_IP stringByAppendingString:@"/app/myInfo/modifyPsd"]

//视频统计管理
//查询
#define VIDEO_STATIST [SERVER_IP stringByAppendingString:@"/app/video/statistics/query"]
//对应教师视频
#define VIDEO_STATIST_TEACHER [SERVER_IP stringByAppendingString:@"/app/video/statistics/queryTeaVideo"]


#endif /* APIConfig_h */
