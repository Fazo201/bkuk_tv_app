import 'package:bkuk_tv_app/src/core/models/menu_config.dart';
import 'package:bkuk_tv_app/src/feature/admin/manager/admin_provider.dart';
import 'package:flutter/material.dart';

MenuConfig? getMenuById(int id) {
  try {
    return menus.firstWhere((e) => e.id == id);
  } catch (_) {
    return null;
  }
}

final List<MenuConfig> menus = [
  MenuConfig(
    id: 1,
    title: "O'zbekiston Respublikasi Kasaba uyushmalari to'g'risidagi qonuni",
    folder: "uzb_kasaba_uyushmalari_qonuni",
    icon: Icons.gavel_outlined,
    singleItem: true,
    getItems: repo.getAllUnionLaws,
    createItem: repo.addUnionLaw,
    updateItem: repo.updateUnionLaw,
    deleteItem: repo.deleteUnionLaw,
  ),
  MenuConfig(
    id: 2,
    title: "O'zbekiston Energetika, neft-gaz va geologiya xodimlari kasaba uyushmasi ustavi",
    folder: "uzb_kasaba_uyushmalari_ustavi",
    icon: Icons.menu_book_rounded,
    singleItem: true,
    getItems: repo.getAllUnionStatutes,
    createItem: repo.addUnionStatute,
    updateItem: repo.updateUnionStatute,
    deleteItem: repo.deleteUnionStatute,
  ),
  MenuConfig(
    id: 3,
    title: "Jamoa shartnomasi",
    folder: "jamoa_shartnomasi",
    icon: Icons.handshake_outlined,
    singleItem: true,
    getItems: repo.getAllCollectiveContracts,
    createItem: repo.addCollectiveContract,
    updateItem: repo.updateCollectiveContract,
    deleteItem: repo.deleteCollectiveContract,
  ),
  MenuConfig(
    id: 4,
    title: "Yo'llanmalar ariza namunalari",
    folder: "yollanmalar_ariza_namunalari",
    icon: Icons.description_outlined,
    getItems: repo.getAllApplicationTemplates,
    createItem: repo.addApplicationTemplate,
    updateItem: repo.updateApplicationTemplate,
    deleteItem: repo.deleteApplicationTemplate,
  ),
  MenuConfig(
    id: 5,
    title: "E'lonlar",
    folder: "elonlar",
    icon: Icons.campaign_outlined,
    getItems: repo.getAllAnnouncements,
    createItem: repo.addAnnouncement,
    updateItem: repo.updateAnnouncement,
    deleteItem: repo.deleteAnnouncement,
  ),
  MenuConfig(
    id: 6,
    title: "Madaniy ma'rifiy ishlar to'g'risida ma'lumot",
    folder: "madaniy_marifiy_ishlar",
    icon: Icons.menu_book_outlined,
    getItems: repo.getAllCulturalInfo,
    createItem: repo.addCulturalInfo,
    updateItem: repo.updateCulturalInfo,
    deleteItem: repo.deleteCulturalInfo,
  ),
  MenuConfig(
    id: 7,
    title: "O'zbekneftegaz AJ tarkibidagi sihatgohlar",
    folder: "sihatgohlar",
    icon: Icons.location_city_outlined,
    getItems: repo.getAllResorts,
    createItem: repo.addResort,
    updateItem: repo.updateResort,
    deleteItem: repo.deleteResort,
  ),
  MenuConfig(
    id: 8,
    title: "O'zbeksiton kasaba uyushmalari Federatsiyasi tarkibidagi sanatoriyalar",
    folder: "sanatoriyalar",
    icon: Icons.favorite_border,
    getItems: repo.getAllSanatoriums,
    createItem: repo.addSanatorium,
    updateItem: repo.updateSanatorium,
    deleteItem: repo.deleteSanatorium,
  ),
  MenuConfig(
    id: 9,
    title: "Kutilayotgan rejalar",
    folder: "kutilayotgan_rejalar",
    icon: Icons.assignment_outlined,
    getItems: repo.getAllUpcomingPlans,
    createItem: repo.addUpcomingPlan,
    updateItem: repo.updateUpcomingPlan,
    deleteItem: repo.deleteUpcomingPlan,
  ),
];