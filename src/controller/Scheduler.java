package controller;

import java.text.SimpleDateFormat;
import java.util.Calendar;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import dao.MemberDAO;
import model.MemberVo;

@Service
public class Scheduler {

	@Autowired
	@Lazy
	MemberDAO mdao;
	
	@Scheduled(cron = "0 0 0 * * *") // 매일 0시0분0초에 실행 ( @초 @분 @시 @일 @월 @요일 순)
	public void permit() {

		Calendar today = Calendar.getInstance();
		String pattern = "yyyy-MM-dd";
		String todate = getCalendarString(today, pattern);

		MemberVo mvo = mdao.banMember(todate);

		String day = mvo.getBan_date();

		if (todate.equals(day)) {

			mvo.setAdmin(0);
			mvo.setBan_date(day);
			mdao.permitMember(mvo);

		}

		int admin = mvo.getAdmin();

		if (admin == 0) {

			mvo.setBan_date(null);
			mvo.setAdmin(0);
			mdao.deleteBandate(mvo);

		}
	}

	private static String getCalendarString(Calendar calendar, String pattern) {
		SimpleDateFormat format = new SimpleDateFormat(pattern);
		return format.format(calendar.getTime());
	}
}