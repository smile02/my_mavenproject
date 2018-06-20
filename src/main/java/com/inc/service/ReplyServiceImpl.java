package com.inc.service;

import com.inc.dao.ReplyDao;
import com.inc.vo.Reply;

public class ReplyServiceImpl implements ReplyService{

	private ReplyDao replyDao;

	public void setReplyDao(ReplyDao replyDao) {
		this.replyDao = replyDao;
	}

	@Override
	public void insert(Reply reply) {
		replyDao.insert(reply);
	}
	
	
}
