insert into hm_settings (settingname, settingstring, settinginteger) values ('usescriptserver', '', 0)

insert into hm_settings (settingname, settingstring, settinginteger) values ('scriptlanguage', 'VBScript', 0)

alter table hm_accounts add accountadminlevel tinyint not null default 0

ALTER TABLE hm_messages CHANGE messageid messageid BIGINT auto_increment NOT NULL

ALTER TABLE hm_messagerecipients CHANGE recipientid recipientid BIGINT auto_increment NOT NULL

ALTER TABLE hm_messagerecipients CHANGE recipientmessageid recipientmessageid BIGINT NOT NULL

ALTER TABLE hm_domains ADD domainaddomain varchar(255) NOT NULL DEFAULT ''

create table hm_fetchaccounts
(	
	faid int auto_increment not null, primary key(`faid`), unique(`faid`),
	faactive tinyint not null,
	faaccountid int not null,
	faaccountname varchar (255) not null,
	faserveraddress varchar (255) not null,
	faserverport int not null,
	faservertype tinyint not null,
	fausername varchar (255) not null,
	fapassword varchar (255) not null,
	faminutes int not null,
	fanexttry datetime not null,
	fadaystokeep int not null,
	falocked tinyint not null
)

create table hm_fetchaccounts_uids
(
	uidid int auto_increment not null, primary key(`uidid`), unique(`uidid`),
	uidfaid int not null,
	uidvalue varchar(255) not null,
	uidtime datetime not null
)

CREATE INDEX idx_hm_fetchaccounts_uids ON hm_fetchaccounts_uids (uidfaid)

create table hm_domain_aliases
(
	daid int auto_increment not null, primary key(`daid`), unique(`daid`),
	dadomainid int not null,
	daalias varchar(255) not null
)

create table hm_rules
(
	ruleid int auto_increment not null, primary key(`ruleid`), unique(`ruleid`),
	ruleaccountid int not null,
	rulename varchar(100) not null,
	ruleactive tinyint not null,
	ruleuseand tinyint not null,
	rulesortorder int not null
)

CREATE INDEX idx_rules ON hm_rules (ruleaccountid)

create table hm_rule_criterias
(
	criteriaid int auto_increment not null, primary key(`criteriaid`), unique(`criteriaid`),
	criteriaruleid int not null,
	criteriausepredefined tinyint not null,
	criteriapredefinedfield tinyint not null,
	criteriaheadername varchar(255) not null,
	criteriamatchtype tinyint not null,
	criteriamatchvalue varchar(255) not null
	
)

CREATE INDEX idx_rules_criterias ON hm_rule_criterias (criteriaruleid)

create table hm_rule_actions
(
	actionid int auto_increment not null, primary key(`actionid`), unique(`actionid`),
	actionruleid int not null,
	actiontype tinyint not null,
	actionimapfolder varchar(255) not null,
	actionsubject varchar(255) not null,
	actionfromname varchar(255) not null,
	actionfromaddress varchar(255) not null,
	actionto varchar(255) not null,
	actionbody text not null,
	actionfilename varchar(255) not null,
	actionsortorder int not null
)

CREATE INDEX idx_rules_actions ON hm_rule_actions (actionruleid)


create table hm_adsynchronization
(
	synchid int auto_increment not null, primary key(`synchid`), unique(`synchid`),
	synchaccountid int not null,
	synchguid varchar(50) not null
)

update hm_accounts set accountmaxsize = accountmaxsize / (1024*1024)

CREATE INDEX idx_hm_accounts ON hm_accounts (accountaddress)

CREATE INDEX idx_hm_aliases ON hm_aliases (aliasdomainid, aliasname)

CREATE INDEX idx_hm_domains ON hm_domains (domainname)

CREATE INDEX idx_hm_messages ON hm_messages (messageaccountid, messagefolderid)

CREATE INDEX idx_hm_distributionlists ON hm_distributionlists (distributionlistdomainid)

CREATE INDEX idx_hm_distributionlistsrecipients ON hm_distributionlistsrecipients (distributionlistrecipientlistid)

CREATE INDEX idx_hm_messagerecipients ON hm_messagerecipients (recipientmessageid)

CREATE INDEX idx_hm_imapfolders ON hm_imapfolders (folderaccountid)

update hm_dbversion set value = 4000

