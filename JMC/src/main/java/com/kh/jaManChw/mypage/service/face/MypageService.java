package com.kh.jaManChw.mypage.service.face;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;

import com.kh.jaManChw.dto.ProfileFile;
import com.kh.jaManChw.dto.Users;
import com.kh.jaManChw.util.Paging;

public interface MypageService {

	/**
	 *  유저 정보 수정
	 * @param users
	 * @return 1: 수정 성공, 0: 수정 실패
	 */
	public int changeInfo(Users users);

	/**
	 * 로그인한 유저의 유저 정보
	 * @param users
	 * @return loginInfo
	 */
	public Users getloginInfo(Users users);

	/**
	 * 회원 탈퇴
	 * @param users
	 * @return 1: 탈퇴 성공, 0: 탈퇴 실패
	 */
	public int deleteUser(Users users);
	
	/**
	 * 파일 정보 조회
	 * @return fileInfo
	 */
	public ProfileFile fileInfo(Users info);

	/**
	 *  파일 업로드
	 * @param file
	 * @param profileFile
	 */
	public ProfileFile profileSave(MultipartFile file,ProfileFile profileFile);


	/**
	 *  프로필사진 삭제
	 * @param profileFile
	 */
	//public void removeProfile(ProfileFile profileFile);

	public int findcntInfo(ProfileFile profileFile);

	/**
	 * 파일 이름 조회하기
	 * @param profileFile
	 * @return
	 */
	public ProfileFile getFileName(ProfileFile profileFile);
	
	/**
	 * 키워드로 유저 검색
	 * @param users
	 * @return 유저 
	 */
	public List<Users> getSearchLists(String type,String keyword);


	







	
	

}
