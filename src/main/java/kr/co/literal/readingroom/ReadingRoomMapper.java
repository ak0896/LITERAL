package kr.co.literal.readingroom;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import kr.co.literal.readingroom.dto.BranchDTO;
import kr.co.literal.readingroom.dto.ReservationDTO;
import kr.co.literal.readingroom.dto.SeatDTO;

@Mapper
public interface ReadingRoomMapper {
    BranchDTO selectBranchByCode(String branch_code);
    List<SeatDTO> selectSeatsByBranchCode(String branch_code);
    void insertReservation(ReservationDTO reservation);
    int getNextReservationCodeNumber(@Param("prefix") String prefix);
}
