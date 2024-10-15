package br.com.grupopipa.financeiro.dto.data;

import lombok.Builder;
import lombok.Getter;
import org.springframework.data.domain.PageRequest;
import org.springframework.util.ObjectUtils;

import java.util.List;
import java.util.Optional;

@Builder
@Getter
public class PageableDataRequest<F extends FilterDTO> {
    private F filter;
    private Integer pageSize;
    private Integer pageNumber;
    private List<Sort> sort;

    public PageRequest getPage() {
        org.springframework.data.domain.Sort sort = buildSort();

        if (!ObjectUtils.isEmpty(sort)) {
            return PageRequest.of(Optional.ofNullable(pageNumber).orElse(0), Optional.ofNullable(pageSize).orElse(10), sort);
        }
        return PageRequest.of(Optional.ofNullable(pageNumber).orElse(0), Optional.ofNullable(pageSize).orElse(10));
    }

    private org.springframework.data.domain.Sort buildSort() {
        if (ObjectUtils.isEmpty(sort)) {
            return null;
        }

        return org.springframework.data.domain.Sort.by(sort.stream().map(this::convertToSortOrder).toList());
    }

    private org.springframework.data.domain.Sort.Order convertToSortOrder(Sort item) {
        if (org.springframework.data.domain.Sort.Direction.ASC.equals(item.getDirection())) {
            return org.springframework.data.domain.Sort.Order.asc(item.getProperty());
        }

        return org.springframework.data.domain.Sort.Order.desc(item.getProperty());
    }
}
