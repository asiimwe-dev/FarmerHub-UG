/// Base mapper interface for DTO <-> Entity conversions
abstract class Mapper<DTO, Entity> {
  Entity toDomain(DTO dto);
  DTO toDTO(Entity entity);
  List<Entity> toDomainList(List<DTO> dtoList) => dtoList.map(toDomain).toList();
  List<DTO> toDTOList(List<Entity> entities) => entities.map(toDTO).toList();
}
