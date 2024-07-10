package kr.co.literal.product;

import org.apache.ibatis.annotations.Mapper;
import java.util.Map;

@Mapper
public interface ProductMapper {
    void insert(Map<String, Object> map);
    boolean bookCodeExists(String bookCode);
    boolean bookNumberExists(String bookNumber);
    int generateBookCode(String genreCode);
    int getNextBookNumber(Map<String, String> params);
}
