package com.model2.mvc.service.upload;

import java.util.List;

import com.model2.mvc.service.domain.Upload;

public interface UploadDao {
	
	public void addUpload(Upload upload) throws Exception;
	
	public List<Upload> getUploadFile(String fileNo) throws Exception;
	
	public void updateUpload(Upload upload) throws Exception;

}
