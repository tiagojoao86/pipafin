package br.com.grupopipa.financeiro.enumeration;

import lombok.Getter;

@Getter
public enum LogicOperatorsEnum {
    OR("or"),
    AND("and");

    final String operator;

    LogicOperatorsEnum(String operator) {
        this.operator = operator;
    }
}
