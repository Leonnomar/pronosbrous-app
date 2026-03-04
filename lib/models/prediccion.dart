class Prediccion {
    final int? golesLocal;
    final int? golesVisitante;
    final String? equipoClasificado;
    String? ganadorPenalesUsuario;

    Prediccion({
        this.golesLocal,
        this.golesVisitante,
        this.equipoClasificado,
    });

    bool get completa => golesLocal != null && golesVisitante != null;

    bool get esEmpate => completa && golesLocal == golesVisitante;

    bool get ganaLocal => completa && golesLocal! > golesVisitante!;

    bool get ganaVisitante => completa && golesVisitante! > golesLocal!;
}