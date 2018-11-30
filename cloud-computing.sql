CREATE DATABASE cloudCoumputing;
USE cloudComputing;

CREATE TABLE availableExecutionFrameworks
{
	framewordID PRIMARY KEY,
	toolType INT,
	makefile INT ,
	maxRAMAllowed INT ,
   	maxDiskSpaceAllowed INT ,
	maxExecutionTimeAllowed INT,
    	maxRequestSize INT ,
    	frameworkDefaultParams INT ,
    	status INT       #(fk? Like active/inactive etc)

};


CREATE TABLE ToolTypes 
{
    toolType PRIMARY KEY
};

CREATE TABLE HandlerTypes 
{
    handlerType INT PRIMARY KEY,
    handlerImagePath INT
};

CREATE TABLE toolsHandlersAssociation
{
    toolType INT REFERENCES ToolTypes(toolType),
    handlerType INT REFERENCES handlerTypes(handlerType),
    PRIMARY KEY (toolType,handlerType)
};

CREATE TABLE frameworkServiceAssociations
{
    serviceID INT REFERENCES services(serviceID),
    frameworkID INT REFERENCES availableExecutionFrameworks(frameworkID),
    PRIMARY KEY (serviceID,frameworkID)
};

CREATE TABLE services 
{
    serviceID PRIMARY KEY,
    description CHAR[100],
    serviceDefaultParams INT ,
    status INT #(fk? Like active/inactive etc)
};

CREATE TABLE clients 
{
    clientID INT PRIMARY KEY
};

CREATE TABLE clientJobs 
{
    jobID INT PRIMARY KEY,
    clientID INT REFERENCES clients(clientID),
    serviceID INT REFERENCES services(serviceID),
    frameworkID INT REFERENCES availableExecutionFrameworks(frameworkId),
    jobParams INT,
    jobSourceCodePath INT ,
    jobStatus INT,# (validating, accepted, rejected,queued, in progress, completed)
    jobStatusDetails CHAR[100],#(v-result,in-prog-estimationoftime, completed-success-fail,queued-seq-no)
    jobOutputFilePath INT,
    PRIMARY KEY (serviceID,frameworkID)
};

CREATE TABLE handlerInstances 
{
    handlerInstanceID INT PRIMARY KEY,
    launchedTimestamp INT,
    status INT ,
    loadStatus INT ,
    garbageStatus INT ,
    ipv4 INT ,
    hostID INT #REFERENCES ____(fk)???????????????
};

CREATE TABLE jobHandlerInstancesAssociations 
{
    jobID INT REFERENCES clientJobs(jobID),#?? WHAT ABOUT PRIMARY KEY??
    handlerInstanceID INT REFERENCES handlerInstances(handlerInstanceID),
    handlerType INT REFERENCES handlerTypes(handlerType),
    jobStartTimestamp INT,
    jobFinishedStatus INT
};

