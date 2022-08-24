package com.model2.mvc.service.domain;

public class Upload {
	
	private String fileNo;
	private int fileCount;
	private String fileName;
	private String file_path;
	private String before_fileName;
	
	public Upload() {
	}

	public Upload(String fileNo, int fileCount, String fileName, String file_path) {
		super();
		this.fileNo = fileNo;
		this.fileCount = fileCount;
		this.fileName = fileName;
		this.file_path = file_path;
	}

	public String getFileNo() {
		return fileNo;
	}

	public void setFileNo(String fileNo) {
		this.fileNo = fileNo;
	}

	public int getFileCount() {
		return fileCount;
	}

	public void setFileCount(int fileCount) {
		this.fileCount = fileCount;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public String getFile_path() {
		return file_path;
	}

	public void setFile_path(String file_path) {
		this.file_path = file_path;
	}

	public String getBefore_fileName() {
		return before_fileName;
	}

	public void setBefore_fileName(String before_fileName) {
		this.before_fileName = before_fileName;
	}

	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("Upload [fileNo=");
		builder.append(fileNo);
		builder.append(", fileCount=");
		builder.append(fileCount);
		builder.append(", fileName=");
		builder.append(fileName);
		builder.append(", file_path=");
		builder.append(file_path);
		builder.append(", before_fileName=");
		builder.append(before_fileName);
		builder.append("]");
		return builder.toString();
	}

}
