package com.inc.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.inc.dao.BoardDao;
import com.inc.vo.Board;

public class BoardServiceImpl implements BoardService{

	private BoardDao boardDao;
	
	//별도에 클래스를 만들어서 상수값만 저장하는 클래스가 있어도 좋음
	public static final int numberOfList = 5;
	public static final int numberOfPage = 3;

	public void setBoardDao(BoardDao boardDao) {
		this.boardDao = boardDao;
	}

	@Override
	public List<Board> list(String option, String text, int page) {
		
		return boardDao.selectList(getSearchMap(option,text,page));
	}

	@Override
	public int getTotalCount(String option, String text, int page) {
		
		return boardDao.totalCount(getSearchMap(option,text,page));
	}
	
	private Map<String, Object> getSearchMap(String option, String text, int page){
		
		int start = (page -1)*numberOfList+1;
		int end = start + numberOfList -1;
		
		Map<String, Object> searchMap = new HashMap<>();
		searchMap.put("start", start);
		searchMap.put("end", end);
		searchMap.put("option", option);
		searchMap.put("text", text);
		
		return searchMap;
	}

	@Override
	public void insert(Board board) {
		boardDao.insert(board);
	}

	@Override
	public void delete(int id) {
		boardDao.delete(id);
	}

	@Override
	public Board selectOne(int id) {
		boardDao.plusHit(id);
		return boardDao.selectOne(id);
	}

	@Override
	public void update(Board board) {
		boardDao.update(board);
	}

	@Override
	public void updateStep(Board board) {
		boardDao.updateStep(board);
	}

	@Override
	public void comment(Board board) {
		boardDao.comment(board);
	}
	
	
}
