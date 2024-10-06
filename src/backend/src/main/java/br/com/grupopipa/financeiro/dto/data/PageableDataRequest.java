package br.com.grupopipa.financeiro.dto.data;

import lombok.Builder;
import lombok.Getter;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.util.ObjectUtils;

import java.util.List;
import java.util.Optional;

@Builder
@Getter
public class PageableDataRequest<F extends FilterDTO> {
    private F filter;
    private Integer pageSize;
    private Integer pageNumber;
    private List<Order> orders;

    public PageRequest getPage() {
        Sort sort = buildSort();

        if (!ObjectUtils.isEmpty(sort)) {
            return PageRequest.of(Optional.ofNullable(pageNumber).orElse(0), Optional.ofNullable(pageSize).orElse(10), sort);
        }
        return PageRequest.of(Optional.ofNullable(pageNumber).orElse(0), Optional.ofNullable(pageSize).orElse(10));
    }

    private Sort buildSort() {
        if (ObjectUtils.isEmpty(orders)) {
            return null;
        }

        return Sort.by(orders.stream().map(this::convertToSortOrder).toList());
    }

    private Sort.Order convertToSortOrder(Order item) {
        if (Sort.Direction.ASC.equals(item.getDirection())) {
            return Sort.Order.asc(item.getProperty());
        }

        return Sort.Order.desc(item.getProperty());
    }
}
