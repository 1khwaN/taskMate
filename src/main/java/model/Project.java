package model;

import java.io.Serializable;
//import java.util.Date;

public class Project implements Serializable{
	
	private static final long serialVersionUID = 1L;
	private int projectID;
	private String projectName;
	private String description;
	private String startDate;
	private String endDate;
	private String projectStatus;
	private String projectPriority;
	
	public Project() {
		
	}

	public int getProjectID() {
		return projectID;
	}

	public void setProjectID(int projectID) {
		this.projectID = projectID;
	}

	public String getProjectName() {
		return projectName;
	}

	public void setProjectName(String projectName) {
		this.projectName = projectName;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getStartDate() {
		return startDate;
	}

	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}

	public String getEndDate() {
		return endDate;
	}

	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}

	public String getProjectStatus() {
		return projectStatus;
	}

	public void setProjectStatus(String projectStatus) {
		this.projectStatus = projectStatus;
	}

	public String getProjectPriority() {
		return projectPriority;
	}

	public void setProjectPriority(String projectPriority) {
		this.projectPriority = projectPriority;
	}

}
