package br.com.grupopipa.financeiro.dto.person;

import br.com.grupopipa.financeiro.dto.DTO;
import br.com.grupopipa.financeiro.entity.PersonEntity;
import br.com.grupopipa.financeiro.enumeration.DocumentTypeEnum;
import br.com.grupopipa.financeiro.enumeration.PersonTypeEnum;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.LocalDateTime;
import java.util.UUID;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class PersonDTO implements DTO<PersonEntity> {

    private UUID id;
    private String name;
    private String fantasyName;
    private PersonTypeEnum personType;
    private String document;
    private DocumentTypeEnum documentType;
    private String addressNumber;
    private String addressStreet;
    private String addressNeighborhood;
    private String addressCity;
    private String addressState;
    private String addressPostalCode;
    private String phone1;
    private String phone2;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
    private String createdBy;
    private String updatedBy;

    @Override
    public UUID getId() {
        return this.id;
    }

    @Override
    public void fillFromEntity(PersonEntity entity) {
        this.id = entity.getId();
        this.name = entity.getName();
        this.fantasyName = entity.getFantasyName();
        this.personType = entity.getPersonType();
        this.document = entity.getDocument();
        this.documentType = entity.getDocumentType();
        this.addressNumber = entity.getAddressNumber();
        this.addressStreet = entity.getAddressStreet();
        this.addressNeighborhood = entity.getAddressNeighborhood();
        this.addressCity = entity.getAddressCity();
        this.addressState = entity.getAddressState();
        this.addressPostalCode = entity.getAddressPostalCode();
        this.phone1 = entity.getPhone1();
        this.phone2 = entity.getPhone2();
        this.createdAt = entity.getCreatedAt();
        this.updatedAt = entity.getUpdatedAt();
        this.createdBy = entity.getCreatedBy();
        this.updatedBy = entity.getUpdatedBy();
    }
}
