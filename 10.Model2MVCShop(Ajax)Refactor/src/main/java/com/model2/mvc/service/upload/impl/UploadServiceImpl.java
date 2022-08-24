package com.model2.mvc.service.upload.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.model2.mvc.service.domain.Upload;
import com.model2.mvc.service.upload.UploadDao;
import com.model2.mvc.service.upload.UploadService;

@Service("uploadServiceImpl")
public class UploadServiceImpl implements UploadService {
	
	@Autowired
	@Qualifier("UploadDaoImpl")
	private UploadDao UploadDaoImpl;

	public UploadServiceImpl() {
		System.out.println(getClass() + " default Constructor");
	}

	@Override
	public void addUpload(Upload upload) throws Exception {
		System.out.println(getClass() + ".addUpload(Upload upload) start...");
		UploadDaoImpl.addUpload(upload);
	}

	@Override
	public List<Upload> getUploadFile(String fileNo) throws Exception {
		System.out.println(getClass() + ".getUploadFile(String fileNo) start...");
		return UploadDaoImpl.getUploadFile(fileNo);
	}

	@Override
	public void updateUpload(Upload upload) throws Exception {
		System.out.println(getClass() + ".updateUpload(Upload upload) start...");
		UploadDaoImpl.updateUpload(upload);
	}

}
