﻿-- 3.9.1408111431
ALTER TABLE TAORGOPLOG ADD (ISPERMISSION VARCHAR2(1));
COMMENT ON COLUMN TAORGOPLOG.ISPERMISSION IS '是否有权限';

DROP TABLE  TADATAACCESSDIMENSION CASCADE CONSTRAINTS;
/*==============================================================*/
/* Table: TADATAACCESSDIMENSION                                                  */
/*==============================================================*/
CREATE TABLE TADATAACCESSDIMENSION (
  DIMENSIONID NUMBER(10,0) NOT NULL,
  POSITIONID NUMBER(10,0) NOT NULL,
  MENUID NUMBER(10,0) NOT NULL,
  DIMENSIONTYPE VARCHAR2(20) NOT NULL,
  DIMENSIONPERMISSIONID VARCHAR2(20),
  ALLACCESS VARCHAR2(1),
  CONSTRAINT PK_TADATAACCESSDIMENSION PRIMARY KEY (DIMENSIONID)
);
COMMENT ON TABLE TADATAACCESSDIMENSION IS '维度数据权限表';
COMMENT ON COLUMN TADATAACCESSDIMENSION.DIMENSIONID IS '维度ID';
COMMENT ON COLUMN TADATAACCESSDIMENSION.POSITIONID IS '岗位ID';
COMMENT ON COLUMN TADATAACCESSDIMENSION.MENUID IS '菜单ID';
COMMENT ON COLUMN TADATAACCESSDIMENSION.DIMENSIONTYPE IS '维度类型';
COMMENT ON COLUMN TADATAACCESSDIMENSION.DIMENSIONPERMISSIONID IS '维度权限ID';
COMMENT ON COLUMN TADATAACCESSDIMENSION.ALLACCESS IS '是否具有该维度所有权限';

INSERT INTO TAMENU (MENUID, PMENUID, MENUNAME, URL, MENUIDPATH, MENUNAMEPATH, ICONSKIN, SELECTIMAGE, REPORTID, ACCESSTIMEEL, EFFECTIVE, SECURITYPOLICY, ISDISMULTIPOS, QUICKCODE, SORTNO, RESOURCETYPE, MENULEVEL, ISLEAF, MENUTYPE, ISCACHE, SYSPATH, USEYAB003, TYPEFLAG) values('24','4','经办机构数据权限管理','org/position/dataAccessDimensionManagementAction.do','1/2/4/23','银海软件/系统管理/组织权限管理/经办机构数据权限管理','tree-database',NULL,NULL,'','0','1','1',NULL,'10','01','4','0','1',NULL,'sysmg',NULL,NULL);

DROP TABLE  T_YAB003 CASCADE CONSTRAINTS;
create global temporary table T_YAB003
(
  YAB003 VARCHAR2(6) not null
)on commit delete rows;
comment on table T_YAB003
  is '经办机构临时表，用于数据权限，会话级';
comment on column T_YAB003.YAB003
  is '经办机构';
alter table T_YAB003
  add constraint PK_T_YAB003 primary key (YAB003);
  
-- 3.9.1408251628

ALTER TABLE TAACCESSLOG ADD (URL VARCHAR2(1024));
ALTER TABLE TAACCESSLOG ADD (SYSFLAG VARCHAR2(50));
COMMENT ON COLUMN TAACCESSLOG.URL IS '访问路径';
COMMENT ON COLUMN TAACCESSLOG.SYSFLAG IS '系统标识';

--  3.9.1409121038 

ALTER TABLE TAPOSITION ADD (POSITIONCATEGORY VARCHAR2(2));
COMMENT ON COLUMN TAPOSITION.POSITIONCATEGORY IS '岗位类别';
INSERT INTO AA10 (AAA100, AAA101, AAA102, AAA103, YAB003, AAE120, VER) VALUES ('POSITIONCATEGORY', '岗位类别', '01', '业务岗', '9999', '0', 0);
INSERT INTO AA10 (AAA100, AAA101, AAA102, AAA103, YAB003, AAE120, VER) VALUES ('POSITIONCATEGORY', '岗位类别', '02', '稽核岗', '9999', '0', 0);

ALTER TABLE TASERVEREXCEPTIONLOG ADD (SYSPATH VARCHAR2(50));
COMMENT ON COLUMN TASERVEREXCEPTIONLOG.SYSPATH IS '系统标识';

INSERT INTO TAMENU (MENUID, PMENUID, MENUNAME, URL, MENUIDPATH, MENUNAMEPATH, ICONSKIN, SELECTIMAGE, REPORTID, ACCESSTIMEEL, EFFECTIVE, SECURITYPOLICY, ISDISMULTIPOS, QUICKCODE, SORTNO, RESOURCETYPE, MENULEVEL, ISLEAF, MENUTYPE, ISCACHE, SYSPATH, USEYAB003, TYPEFLAG) values('28','2','系统路径管理','sysapp/configSysPathAction.do','1/2/4/28','银海软件/系统路径管理','tree-database',NULL,NULL,'','0','1','1',NULL,'7','01','4','0','1',NULL,'sysmg',NULL,NULL);

ALTER TABLE TADATAACCESSDIMENSION ADD (SYSPATH VARCHAR2(50));
COMMENT ON COLUMN TADATAACCESSDIMENSION.SYSPATH IS '系统标识';

CREATE OR REPLACE VIEW YAB003_V AS
SELECT
       U.USERID AS USERID,
       M.MENUID AS MENUID,
       DAD.DIMENSIONPERMISSIONID AS YAB003,
       DAD.SYSPATH AS SYSPATH
FROM
       TAMENU M ,
       TADATAACCESSDIMENSION DAD,
       TAUSER U,
       TAPOSITION P,
       TAUSERPOSITION UP
WHERE 1=1
      AND U.USERID=UP.USERID
      AND (U.DESTORY IS NULL OR U.DESTORY=0)
      AND U.EFFECTIVE=0
      AND UP.POSITIONID=P.POSITIONID
      AND P.EFFECTIVE=0
      AND (P.VALIDTIME IS NULL OR P.VALIDTIME>=sysdate)
      AND P.POSITIONID=DAD.POSITIONID
      AND DAD.MENUID=M.MENUID
      AND DAD.DIMENSIONTYPE='YAB003'
      AND DAD.ALLACCESS<>0
UNION
SELECT
       U.USERID AS USERID,
       M.MENUID AS MENUID,
       A.AAA102 AS YAB003,
       DAD.SYSPATH AS SYSPATH
FROM
       TAMENU M ,
       TADATAACCESSDIMENSION DAD,
       TAUSER U,
       TAPOSITION P,
       TAUSERPOSITION UP,
       AA10A1 A
WHERE 1=1
      AND U.USERID=UP.USERID
      AND (U.DESTORY IS NULL OR U.DESTORY=0)
      AND U.EFFECTIVE=0
      AND UP.POSITIONID=P.POSITIONID
      AND P.EFFECTIVE=0
      AND (P.VALIDTIME IS NULL OR P.VALIDTIME>=sysdate)
      AND P.POSITIONID=DAD.POSITIONID
      AND DAD.MENUID=M.MENUID
      AND DAD.DIMENSIONTYPE='YAB003'
      AND DAD.ALLACCESS=0
      AND A.AAA100='YAB003';

-- 3.9.1411031447
DROP VIEW YAB003_V;
DROP TABLE T_YAB003 CASCADE CONSTRAINTS;
CREATE OR REPLACE VIEW V_YAB139 AS
SELECT
       U.USERID AS USERID,
       M.MENUID AS MENUID,
       DAD.DIMENSIONPERMISSIONID AS YAB139,
       DAD.SYSPATH AS SYSPATH
FROM
       TAMENU M ,
       TADATAACCESSDIMENSION DAD,
       TAUSER U,
       TAPOSITION P,
       TAUSERPOSITION UP
WHERE 1=1
      AND U.USERID=UP.USERID
      AND (U.DESTORY IS NULL OR U.DESTORY=0)
      AND U.EFFECTIVE=0
      AND UP.POSITIONID=P.POSITIONID
      AND P.EFFECTIVE=0
      AND (P.VALIDTIME IS NULL OR P.VALIDTIME>=sysdate)
      AND P.POSITIONID=DAD.POSITIONID
      AND DAD.MENUID=M.MENUID
      AND DAD.DIMENSIONTYPE='YAB139'
      AND DAD.ALLACCESS<>0
UNION
SELECT
       U.USERID AS USERID,
       M.MENUID AS MENUID,
       A.AAA102 AS YAB139,
       DAD.SYSPATH AS SYSPATH
FROM
       TAMENU M ,
       TADATAACCESSDIMENSION DAD,
       TAUSER U,
       TAPOSITION P,
       TAUSERPOSITION UP,
       AA10A1 A
WHERE 1=1
      AND U.USERID=UP.USERID
      AND (U.DESTORY IS NULL OR U.DESTORY=0)
      AND U.EFFECTIVE=0
      AND UP.POSITIONID=P.POSITIONID
      AND P.EFFECTIVE=0
      AND (P.VALIDTIME IS NULL OR P.VALIDTIME>=sysdate)
      AND P.POSITIONID=DAD.POSITIONID
      AND DAD.MENUID=M.MENUID
      AND DAD.DIMENSIONTYPE='YAB139'
      AND DAD.ALLACCESS=0
      AND A.AAA100='YAB139';

DROP TABLE TAADMINYAB139SCOPE CASCADE CONSTRAINTS;
CREATE TABLE TAADMINYAB139SCOPE (
  POSITIONID NUMBER(10) NOT NULL ,
  YAB139   VARCHAR2(6) NOT NULL,
  constraint PK_TAADMINYAB139SCOPE primary key (POSITIONID,YAB139)
);
COMMENT ON TABLE TAADMINYAB139SCOPE IS
'管理员数据区管理范围';
COMMENT ON COLUMN TAADMINYAB139SCOPE.POSITIONID IS
'岗位id';
COMMENT ON COLUMN TAADMINYAB139SCOPE.YAB139 IS
'数据区';
INSERT INTO TAADMINYAB139SCOPE(POSITIONID,YAB139) SELECT T.POSITIONID,T.YAB003 FROM TAADMINYAB003SCOPE T;
DROP TABLE TAADMINYAB003SCOPE CASCADE CONSTRAINTS;

ALTER TABLE TAORG ADD (YAB139 VARCHAR2(6));
COMMENT ON COLUMN TAORG.YAB139 IS '数据区';

ALTER TABLE TAPOSITIONAUTHRITY ADD (AUDITEACCESSDATE DATE);
COMMENT ON COLUMN TAPOSITIONAUTHRITY.AUDITEACCESSDATE IS '审核通过时间';
ALTER TABLE TAPOSITIONAUTHRITY ADD (AUDITEUSER NUMBER(10));
COMMENT ON COLUMN TAPOSITIONAUTHRITY.AUDITEUSER IS '审核人';
ALTER TABLE TAPOSITIONAUTHRITY ADD (AUDITSTATE VARCHAR2(1));
COMMENT ON COLUMN TAPOSITIONAUTHRITY.AUDITSTATE IS '审核状态';
ALTER TABLE TAPOSITIONAUTHRITY MODIFY AUDITSTATE DEFAULT 0;
ALTER TABLE TAMENU ADD (ISAUDITE VARCHAR2(1) default 1);
COMMENT ON COLUMN TAMENU.ISAUDITE IS '是否需要审核';
UPDATE TAMENU SET ISAUDITE=1 WHERE ISAUDITE IS NULL;
UPDATE TAPOSITIONAUTHRITY SET AUDITSTATE=0;


INSERT INTO AA10 (AAA100, AAA101, AAA102, AAA103, YAB003, AAE120, VER) VALUES ('AUDITSTATE', '审核状态', '0', '无需审核', '9999', '0', 0);
INSERT INTO AA10 (AAA100, AAA101, AAA102, AAA103, YAB003, AAE120, VER) VALUES ('AUDITSTATE', '审核状态', '1', '待审核', '9999', '0', 0);
INSERT INTO AA10 (AAA100, AAA101, AAA102, AAA103, YAB003, AAE120, VER) VALUES ('AUDITSTATE', '审核状态', '2', '审核通过', '9999', '0', 0);
INSERT INTO AA10 (AAA100, AAA101, AAA102, AAA103, YAB003, AAE120, VER) VALUES ('AUDITSTATE', '审核状态', '3', '审核未通过', '9999', '0', 0);

DROP TABLE TAYAB139MG CASCADE CONSTRAINTS;
CREATE TABLE TAYAB139MG
(
  YAB003 VARCHAR2(6),
  YAB139 VARCHAR2(20)
);

comment on table TAYAB139MG
  is '经办机构管理数据区范围';
comment on column TAYAB139MG.YAB003
  is '经办机构';
comment on column TAYAB139MG.YAB139
  is '数据区';
  
DROP TABLE TAYAB003LEVELMG CASCADE CONSTRAINTS;
CREATE TABLE TAYAB003LEVELMG
(
  PYAB003 VARCHAR2(6),
  YAB003  VARCHAR2(6)
);

comment on table TAYAB003LEVELMG
  is '经办机构层级关系管理';
comment on column TAYAB003LEVELMG.PYAB003
  is '父经办机构';
comment on column TAYAB003LEVELMG.YAB003
  is '经办机构';
 
INSERT INTO TAMENU (MENUID, PMENUID, MENUNAME, URL, MENUIDPATH, MENUNAMEPATH, ICONSKIN, SELECTIMAGE, REPORTID, ACCESSTIMEEL, EFFECTIVE, SECURITYPOLICY, ISDISMULTIPOS, QUICKCODE, SORTNO, RESOURCETYPE, MENULEVEL, ISLEAF, MENUTYPE, ISCACHE, SYSPATH, USEYAB003, TYPEFLAG, ISAUDITE)
VALUES (30, 4, '权限内控', 'org/position/innerControlAction.do', '1/2/4/30', '银海软件/系统管理/组织权限管理/权限内控', 'tree-edit-redo', '', '', '', '0', '1', '1', '', 11, '01', 4, '0', '1', '', 'sysmg', '1', null, '1');

INSERT INTO tamenu (MENUID, PMENUID, MENUNAME, URL, MENUIDPATH, MENUNAMEPATH, ICONSKIN, SELECTIMAGE, REPORTID, ACCESSTIMEEL, EFFECTIVE, SECURITYPOLICY, ISDISMULTIPOS, QUICKCODE, SORTNO, RESOURCETYPE, MENULEVEL, ISLEAF, MENUTYPE, ISCACHE, SYSPATH, USEYAB003, TYPEFLAG, ISAUDITE)
VALUES (29, 4, '经办机构数据区管理', 'org/position/yab003MgAction.do', '1/2/4/29', '银海软件/系统管理/组织权限管理/经办机构数据区管理', 'tree-organisation', '', '', '', '0', '1', '1', '', 10, '01', 4, '0', '1', '', 'sysmg', '1', null, '1');


ALTER TABLE TASERVEREXCEPTIONLOG ADD (CLIENTIP VARCHAR2(50));
 COMMENT ON COLUMN TASERVEREXCEPTIONLOG.CLIENTIP IS '客户端ip';
ALTER TABLE TASERVEREXCEPTIONLOG ADD (URL VARCHAR2(100)); 
 COMMENT ON COLUMN TASERVEREXCEPTIONLOG.URL IS '访问功能url';
ALTER TABLE TASERVEREXCEPTIONLOG ADD (MENUID VARCHAR2(8));
 COMMENT ON COLUMN TASERVEREXCEPTIONLOG.MENUID IS '菜单id';
ALTER TABLE TASERVEREXCEPTIONLOG ADD (MENUNAME VARCHAR2(30));
 COMMENT ON COLUMN TASERVEREXCEPTIONLOG.MENUNAME IS '菜单名称';
ALTER TABLE TASERVEREXCEPTIONLOG ADD (USERAGENT VARCHAR2(200));
 COMMENT ON COLUMN TASERVEREXCEPTIONLOG.USERAGENT IS '客户端环境';

ALTER TABLE TAMENU ADD (CONSOLEMODULE CHAR(1) DEFAULT 1);
 COMMENT ON COLUMN TAMENU.CONSOLEMODULE IS '是否为工作台模块';
commit work;