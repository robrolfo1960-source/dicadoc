// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $PazientiTable extends Pazienti with TableInfo<$PazientiTable, Paziente> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PazientiTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _cognomeMeta =
      const VerificationMeta('cognome');
  @override
  late final GeneratedColumn<String> cognome = GeneratedColumn<String>(
      'cognome', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nomeMeta = const VerificationMeta('nome');
  @override
  late final GeneratedColumn<String> nome = GeneratedColumn<String>(
      'nome', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _codiceFiscaleMeta =
      const VerificationMeta('codiceFiscale');
  @override
  late final GeneratedColumn<String> codiceFiscale = GeneratedColumn<String>(
      'codice_fiscale', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 11, maxTextLength: 16),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _dataNascitaMeta =
      const VerificationMeta('dataNascita');
  @override
  late final GeneratedColumn<DateTime> dataNascita = GeneratedColumn<DateTime>(
      'data_nascita', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _indirizzoMeta =
      const VerificationMeta('indirizzo');
  @override
  late final GeneratedColumn<String> indirizzo = GeneratedColumn<String>(
      'indirizzo', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _telefonoMeta =
      const VerificationMeta('telefono');
  @override
  late final GeneratedColumn<String> telefono = GeneratedColumn<String>(
      'telefono', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _cellulareMeta =
      const VerificationMeta('cellulare');
  @override
  late final GeneratedColumn<String> cellulare = GeneratedColumn<String>(
      'cellulare', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
      'email', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        cognome,
        nome,
        codiceFiscale,
        dataNascita,
        indirizzo,
        telefono,
        cellulare,
        email
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'pazienti';
  @override
  VerificationContext validateIntegrity(Insertable<Paziente> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('cognome')) {
      context.handle(_cognomeMeta,
          cognome.isAcceptableOrUnknown(data['cognome']!, _cognomeMeta));
    } else if (isInserting) {
      context.missing(_cognomeMeta);
    }
    if (data.containsKey('nome')) {
      context.handle(
          _nomeMeta, nome.isAcceptableOrUnknown(data['nome']!, _nomeMeta));
    } else if (isInserting) {
      context.missing(_nomeMeta);
    }
    if (data.containsKey('codice_fiscale')) {
      context.handle(
          _codiceFiscaleMeta,
          codiceFiscale.isAcceptableOrUnknown(
              data['codice_fiscale']!, _codiceFiscaleMeta));
    } else if (isInserting) {
      context.missing(_codiceFiscaleMeta);
    }
    if (data.containsKey('data_nascita')) {
      context.handle(
          _dataNascitaMeta,
          dataNascita.isAcceptableOrUnknown(
              data['data_nascita']!, _dataNascitaMeta));
    } else if (isInserting) {
      context.missing(_dataNascitaMeta);
    }
    if (data.containsKey('indirizzo')) {
      context.handle(_indirizzoMeta,
          indirizzo.isAcceptableOrUnknown(data['indirizzo']!, _indirizzoMeta));
    }
    if (data.containsKey('telefono')) {
      context.handle(_telefonoMeta,
          telefono.isAcceptableOrUnknown(data['telefono']!, _telefonoMeta));
    }
    if (data.containsKey('cellulare')) {
      context.handle(_cellulareMeta,
          cellulare.isAcceptableOrUnknown(data['cellulare']!, _cellulareMeta));
    } else if (isInserting) {
      context.missing(_cellulareMeta);
    }
    if (data.containsKey('email')) {
      context.handle(
          _emailMeta, email.isAcceptableOrUnknown(data['email']!, _emailMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Paziente map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Paziente(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      cognome: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}cognome'])!,
      nome: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}nome'])!,
      codiceFiscale: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}codice_fiscale'])!,
      dataNascita: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}data_nascita'])!,
      indirizzo: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}indirizzo']),
      telefono: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}telefono']),
      cellulare: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}cellulare'])!,
      email: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}email']),
    );
  }

  @override
  $PazientiTable createAlias(String alias) {
    return $PazientiTable(attachedDatabase, alias);
  }
}

class Paziente extends DataClass implements Insertable<Paziente> {
  final int id;
  final String cognome;
  final String nome;
  final String codiceFiscale;
  final DateTime dataNascita;
  final String? indirizzo;
  final String? telefono;
  final String cellulare;
  final String? email;
  const Paziente(
      {required this.id,
      required this.cognome,
      required this.nome,
      required this.codiceFiscale,
      required this.dataNascita,
      this.indirizzo,
      this.telefono,
      required this.cellulare,
      this.email});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['cognome'] = Variable<String>(cognome);
    map['nome'] = Variable<String>(nome);
    map['codice_fiscale'] = Variable<String>(codiceFiscale);
    map['data_nascita'] = Variable<DateTime>(dataNascita);
    if (!nullToAbsent || indirizzo != null) {
      map['indirizzo'] = Variable<String>(indirizzo);
    }
    if (!nullToAbsent || telefono != null) {
      map['telefono'] = Variable<String>(telefono);
    }
    map['cellulare'] = Variable<String>(cellulare);
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
    }
    return map;
  }

  PazientiCompanion toCompanion(bool nullToAbsent) {
    return PazientiCompanion(
      id: Value(id),
      cognome: Value(cognome),
      nome: Value(nome),
      codiceFiscale: Value(codiceFiscale),
      dataNascita: Value(dataNascita),
      indirizzo: indirizzo == null && nullToAbsent
          ? const Value.absent()
          : Value(indirizzo),
      telefono: telefono == null && nullToAbsent
          ? const Value.absent()
          : Value(telefono),
      cellulare: Value(cellulare),
      email:
          email == null && nullToAbsent ? const Value.absent() : Value(email),
    );
  }

  factory Paziente.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Paziente(
      id: serializer.fromJson<int>(json['id']),
      cognome: serializer.fromJson<String>(json['cognome']),
      nome: serializer.fromJson<String>(json['nome']),
      codiceFiscale: serializer.fromJson<String>(json['codiceFiscale']),
      dataNascita: serializer.fromJson<DateTime>(json['dataNascita']),
      indirizzo: serializer.fromJson<String?>(json['indirizzo']),
      telefono: serializer.fromJson<String?>(json['telefono']),
      cellulare: serializer.fromJson<String>(json['cellulare']),
      email: serializer.fromJson<String?>(json['email']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'cognome': serializer.toJson<String>(cognome),
      'nome': serializer.toJson<String>(nome),
      'codiceFiscale': serializer.toJson<String>(codiceFiscale),
      'dataNascita': serializer.toJson<DateTime>(dataNascita),
      'indirizzo': serializer.toJson<String?>(indirizzo),
      'telefono': serializer.toJson<String?>(telefono),
      'cellulare': serializer.toJson<String>(cellulare),
      'email': serializer.toJson<String?>(email),
    };
  }

  Paziente copyWith(
          {int? id,
          String? cognome,
          String? nome,
          String? codiceFiscale,
          DateTime? dataNascita,
          Value<String?> indirizzo = const Value.absent(),
          Value<String?> telefono = const Value.absent(),
          String? cellulare,
          Value<String?> email = const Value.absent()}) =>
      Paziente(
        id: id ?? this.id,
        cognome: cognome ?? this.cognome,
        nome: nome ?? this.nome,
        codiceFiscale: codiceFiscale ?? this.codiceFiscale,
        dataNascita: dataNascita ?? this.dataNascita,
        indirizzo: indirizzo.present ? indirizzo.value : this.indirizzo,
        telefono: telefono.present ? telefono.value : this.telefono,
        cellulare: cellulare ?? this.cellulare,
        email: email.present ? email.value : this.email,
      );
  Paziente copyWithCompanion(PazientiCompanion data) {
    return Paziente(
      id: data.id.present ? data.id.value : this.id,
      cognome: data.cognome.present ? data.cognome.value : this.cognome,
      nome: data.nome.present ? data.nome.value : this.nome,
      codiceFiscale: data.codiceFiscale.present
          ? data.codiceFiscale.value
          : this.codiceFiscale,
      dataNascita:
          data.dataNascita.present ? data.dataNascita.value : this.dataNascita,
      indirizzo: data.indirizzo.present ? data.indirizzo.value : this.indirizzo,
      telefono: data.telefono.present ? data.telefono.value : this.telefono,
      cellulare: data.cellulare.present ? data.cellulare.value : this.cellulare,
      email: data.email.present ? data.email.value : this.email,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Paziente(')
          ..write('id: $id, ')
          ..write('cognome: $cognome, ')
          ..write('nome: $nome, ')
          ..write('codiceFiscale: $codiceFiscale, ')
          ..write('dataNascita: $dataNascita, ')
          ..write('indirizzo: $indirizzo, ')
          ..write('telefono: $telefono, ')
          ..write('cellulare: $cellulare, ')
          ..write('email: $email')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, cognome, nome, codiceFiscale, dataNascita,
      indirizzo, telefono, cellulare, email);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Paziente &&
          other.id == this.id &&
          other.cognome == this.cognome &&
          other.nome == this.nome &&
          other.codiceFiscale == this.codiceFiscale &&
          other.dataNascita == this.dataNascita &&
          other.indirizzo == this.indirizzo &&
          other.telefono == this.telefono &&
          other.cellulare == this.cellulare &&
          other.email == this.email);
}

class PazientiCompanion extends UpdateCompanion<Paziente> {
  final Value<int> id;
  final Value<String> cognome;
  final Value<String> nome;
  final Value<String> codiceFiscale;
  final Value<DateTime> dataNascita;
  final Value<String?> indirizzo;
  final Value<String?> telefono;
  final Value<String> cellulare;
  final Value<String?> email;
  const PazientiCompanion({
    this.id = const Value.absent(),
    this.cognome = const Value.absent(),
    this.nome = const Value.absent(),
    this.codiceFiscale = const Value.absent(),
    this.dataNascita = const Value.absent(),
    this.indirizzo = const Value.absent(),
    this.telefono = const Value.absent(),
    this.cellulare = const Value.absent(),
    this.email = const Value.absent(),
  });
  PazientiCompanion.insert({
    this.id = const Value.absent(),
    required String cognome,
    required String nome,
    required String codiceFiscale,
    required DateTime dataNascita,
    this.indirizzo = const Value.absent(),
    this.telefono = const Value.absent(),
    required String cellulare,
    this.email = const Value.absent(),
  })  : cognome = Value(cognome),
        nome = Value(nome),
        codiceFiscale = Value(codiceFiscale),
        dataNascita = Value(dataNascita),
        cellulare = Value(cellulare);
  static Insertable<Paziente> custom({
    Expression<int>? id,
    Expression<String>? cognome,
    Expression<String>? nome,
    Expression<String>? codiceFiscale,
    Expression<DateTime>? dataNascita,
    Expression<String>? indirizzo,
    Expression<String>? telefono,
    Expression<String>? cellulare,
    Expression<String>? email,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (cognome != null) 'cognome': cognome,
      if (nome != null) 'nome': nome,
      if (codiceFiscale != null) 'codice_fiscale': codiceFiscale,
      if (dataNascita != null) 'data_nascita': dataNascita,
      if (indirizzo != null) 'indirizzo': indirizzo,
      if (telefono != null) 'telefono': telefono,
      if (cellulare != null) 'cellulare': cellulare,
      if (email != null) 'email': email,
    });
  }

  PazientiCompanion copyWith(
      {Value<int>? id,
      Value<String>? cognome,
      Value<String>? nome,
      Value<String>? codiceFiscale,
      Value<DateTime>? dataNascita,
      Value<String?>? indirizzo,
      Value<String?>? telefono,
      Value<String>? cellulare,
      Value<String?>? email}) {
    return PazientiCompanion(
      id: id ?? this.id,
      cognome: cognome ?? this.cognome,
      nome: nome ?? this.nome,
      codiceFiscale: codiceFiscale ?? this.codiceFiscale,
      dataNascita: dataNascita ?? this.dataNascita,
      indirizzo: indirizzo ?? this.indirizzo,
      telefono: telefono ?? this.telefono,
      cellulare: cellulare ?? this.cellulare,
      email: email ?? this.email,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (cognome.present) {
      map['cognome'] = Variable<String>(cognome.value);
    }
    if (nome.present) {
      map['nome'] = Variable<String>(nome.value);
    }
    if (codiceFiscale.present) {
      map['codice_fiscale'] = Variable<String>(codiceFiscale.value);
    }
    if (dataNascita.present) {
      map['data_nascita'] = Variable<DateTime>(dataNascita.value);
    }
    if (indirizzo.present) {
      map['indirizzo'] = Variable<String>(indirizzo.value);
    }
    if (telefono.present) {
      map['telefono'] = Variable<String>(telefono.value);
    }
    if (cellulare.present) {
      map['cellulare'] = Variable<String>(cellulare.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PazientiCompanion(')
          ..write('id: $id, ')
          ..write('cognome: $cognome, ')
          ..write('nome: $nome, ')
          ..write('codiceFiscale: $codiceFiscale, ')
          ..write('dataNascita: $dataNascita, ')
          ..write('indirizzo: $indirizzo, ')
          ..write('telefono: $telefono, ')
          ..write('cellulare: $cellulare, ')
          ..write('email: $email')
          ..write(')'))
        .toString();
  }
}

class $PatologieTable extends Patologie
    with TableInfo<$PatologieTable, Patologia> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PatologieTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _pazienteIdMeta =
      const VerificationMeta('pazienteId');
  @override
  late final GeneratedColumn<int> pazienteId = GeneratedColumn<int>(
      'paziente_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES pazienti (id)'));
  static const VerificationMeta _nomeMeta = const VerificationMeta('nome');
  @override
  late final GeneratedColumn<String> nome = GeneratedColumn<String>(
      'nome', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, pazienteId, nome];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'patologie';
  @override
  VerificationContext validateIntegrity(Insertable<Patologia> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('paziente_id')) {
      context.handle(
          _pazienteIdMeta,
          pazienteId.isAcceptableOrUnknown(
              data['paziente_id']!, _pazienteIdMeta));
    } else if (isInserting) {
      context.missing(_pazienteIdMeta);
    }
    if (data.containsKey('nome')) {
      context.handle(
          _nomeMeta, nome.isAcceptableOrUnknown(data['nome']!, _nomeMeta));
    } else if (isInserting) {
      context.missing(_nomeMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Patologia map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Patologia(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      pazienteId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}paziente_id'])!,
      nome: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}nome'])!,
    );
  }

  @override
  $PatologieTable createAlias(String alias) {
    return $PatologieTable(attachedDatabase, alias);
  }
}

class Patologia extends DataClass implements Insertable<Patologia> {
  final int id;
  final int pazienteId;
  final String nome;
  const Patologia(
      {required this.id, required this.pazienteId, required this.nome});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['paziente_id'] = Variable<int>(pazienteId);
    map['nome'] = Variable<String>(nome);
    return map;
  }

  PatologieCompanion toCompanion(bool nullToAbsent) {
    return PatologieCompanion(
      id: Value(id),
      pazienteId: Value(pazienteId),
      nome: Value(nome),
    );
  }

  factory Patologia.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Patologia(
      id: serializer.fromJson<int>(json['id']),
      pazienteId: serializer.fromJson<int>(json['pazienteId']),
      nome: serializer.fromJson<String>(json['nome']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'pazienteId': serializer.toJson<int>(pazienteId),
      'nome': serializer.toJson<String>(nome),
    };
  }

  Patologia copyWith({int? id, int? pazienteId, String? nome}) => Patologia(
        id: id ?? this.id,
        pazienteId: pazienteId ?? this.pazienteId,
        nome: nome ?? this.nome,
      );
  Patologia copyWithCompanion(PatologieCompanion data) {
    return Patologia(
      id: data.id.present ? data.id.value : this.id,
      pazienteId:
          data.pazienteId.present ? data.pazienteId.value : this.pazienteId,
      nome: data.nome.present ? data.nome.value : this.nome,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Patologia(')
          ..write('id: $id, ')
          ..write('pazienteId: $pazienteId, ')
          ..write('nome: $nome')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, pazienteId, nome);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Patologia &&
          other.id == this.id &&
          other.pazienteId == this.pazienteId &&
          other.nome == this.nome);
}

class PatologieCompanion extends UpdateCompanion<Patologia> {
  final Value<int> id;
  final Value<int> pazienteId;
  final Value<String> nome;
  const PatologieCompanion({
    this.id = const Value.absent(),
    this.pazienteId = const Value.absent(),
    this.nome = const Value.absent(),
  });
  PatologieCompanion.insert({
    this.id = const Value.absent(),
    required int pazienteId,
    required String nome,
  })  : pazienteId = Value(pazienteId),
        nome = Value(nome);
  static Insertable<Patologia> custom({
    Expression<int>? id,
    Expression<int>? pazienteId,
    Expression<String>? nome,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (pazienteId != null) 'paziente_id': pazienteId,
      if (nome != null) 'nome': nome,
    });
  }

  PatologieCompanion copyWith(
      {Value<int>? id, Value<int>? pazienteId, Value<String>? nome}) {
    return PatologieCompanion(
      id: id ?? this.id,
      pazienteId: pazienteId ?? this.pazienteId,
      nome: nome ?? this.nome,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (pazienteId.present) {
      map['paziente_id'] = Variable<int>(pazienteId.value);
    }
    if (nome.present) {
      map['nome'] = Variable<String>(nome.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PatologieCompanion(')
          ..write('id: $id, ')
          ..write('pazienteId: $pazienteId, ')
          ..write('nome: $nome')
          ..write(')'))
        .toString();
  }
}

class $RisposteAnamnesiTable extends RisposteAnamnesi
    with TableInfo<$RisposteAnamnesiTable, RispostaAnamnesi> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RisposteAnamnesiTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _pazienteIdMeta =
      const VerificationMeta('pazienteId');
  @override
  late final GeneratedColumn<int> pazienteId = GeneratedColumn<int>(
      'paziente_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES pazienti (id)'));
  static const VerificationMeta _domandaMeta =
      const VerificationMeta('domanda');
  @override
  late final GeneratedColumn<String> domanda = GeneratedColumn<String>(
      'domanda', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _rispostaMeta =
      const VerificationMeta('risposta');
  @override
  late final GeneratedColumn<bool> risposta = GeneratedColumn<bool>(
      'risposta', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("risposta" IN (0, 1))'));
  @override
  List<GeneratedColumn> get $columns => [id, pazienteId, domanda, risposta];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'risposte_anamnesi';
  @override
  VerificationContext validateIntegrity(Insertable<RispostaAnamnesi> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('paziente_id')) {
      context.handle(
          _pazienteIdMeta,
          pazienteId.isAcceptableOrUnknown(
              data['paziente_id']!, _pazienteIdMeta));
    } else if (isInserting) {
      context.missing(_pazienteIdMeta);
    }
    if (data.containsKey('domanda')) {
      context.handle(_domandaMeta,
          domanda.isAcceptableOrUnknown(data['domanda']!, _domandaMeta));
    } else if (isInserting) {
      context.missing(_domandaMeta);
    }
    if (data.containsKey('risposta')) {
      context.handle(_rispostaMeta,
          risposta.isAcceptableOrUnknown(data['risposta']!, _rispostaMeta));
    } else if (isInserting) {
      context.missing(_rispostaMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RispostaAnamnesi map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RispostaAnamnesi(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      pazienteId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}paziente_id'])!,
      domanda: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}domanda'])!,
      risposta: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}risposta'])!,
    );
  }

  @override
  $RisposteAnamnesiTable createAlias(String alias) {
    return $RisposteAnamnesiTable(attachedDatabase, alias);
  }
}

class RispostaAnamnesi extends DataClass
    implements Insertable<RispostaAnamnesi> {
  final int id;
  final int pazienteId;
  final String domanda;
  final bool risposta;
  const RispostaAnamnesi(
      {required this.id,
      required this.pazienteId,
      required this.domanda,
      required this.risposta});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['paziente_id'] = Variable<int>(pazienteId);
    map['domanda'] = Variable<String>(domanda);
    map['risposta'] = Variable<bool>(risposta);
    return map;
  }

  RisposteAnamnesiCompanion toCompanion(bool nullToAbsent) {
    return RisposteAnamnesiCompanion(
      id: Value(id),
      pazienteId: Value(pazienteId),
      domanda: Value(domanda),
      risposta: Value(risposta),
    );
  }

  factory RispostaAnamnesi.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RispostaAnamnesi(
      id: serializer.fromJson<int>(json['id']),
      pazienteId: serializer.fromJson<int>(json['pazienteId']),
      domanda: serializer.fromJson<String>(json['domanda']),
      risposta: serializer.fromJson<bool>(json['risposta']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'pazienteId': serializer.toJson<int>(pazienteId),
      'domanda': serializer.toJson<String>(domanda),
      'risposta': serializer.toJson<bool>(risposta),
    };
  }

  RispostaAnamnesi copyWith(
          {int? id, int? pazienteId, String? domanda, bool? risposta}) =>
      RispostaAnamnesi(
        id: id ?? this.id,
        pazienteId: pazienteId ?? this.pazienteId,
        domanda: domanda ?? this.domanda,
        risposta: risposta ?? this.risposta,
      );
  RispostaAnamnesi copyWithCompanion(RisposteAnamnesiCompanion data) {
    return RispostaAnamnesi(
      id: data.id.present ? data.id.value : this.id,
      pazienteId:
          data.pazienteId.present ? data.pazienteId.value : this.pazienteId,
      domanda: data.domanda.present ? data.domanda.value : this.domanda,
      risposta: data.risposta.present ? data.risposta.value : this.risposta,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RispostaAnamnesi(')
          ..write('id: $id, ')
          ..write('pazienteId: $pazienteId, ')
          ..write('domanda: $domanda, ')
          ..write('risposta: $risposta')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, pazienteId, domanda, risposta);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RispostaAnamnesi &&
          other.id == this.id &&
          other.pazienteId == this.pazienteId &&
          other.domanda == this.domanda &&
          other.risposta == this.risposta);
}

class RisposteAnamnesiCompanion extends UpdateCompanion<RispostaAnamnesi> {
  final Value<int> id;
  final Value<int> pazienteId;
  final Value<String> domanda;
  final Value<bool> risposta;
  const RisposteAnamnesiCompanion({
    this.id = const Value.absent(),
    this.pazienteId = const Value.absent(),
    this.domanda = const Value.absent(),
    this.risposta = const Value.absent(),
  });
  RisposteAnamnesiCompanion.insert({
    this.id = const Value.absent(),
    required int pazienteId,
    required String domanda,
    required bool risposta,
  })  : pazienteId = Value(pazienteId),
        domanda = Value(domanda),
        risposta = Value(risposta);
  static Insertable<RispostaAnamnesi> custom({
    Expression<int>? id,
    Expression<int>? pazienteId,
    Expression<String>? domanda,
    Expression<bool>? risposta,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (pazienteId != null) 'paziente_id': pazienteId,
      if (domanda != null) 'domanda': domanda,
      if (risposta != null) 'risposta': risposta,
    });
  }

  RisposteAnamnesiCompanion copyWith(
      {Value<int>? id,
      Value<int>? pazienteId,
      Value<String>? domanda,
      Value<bool>? risposta}) {
    return RisposteAnamnesiCompanion(
      id: id ?? this.id,
      pazienteId: pazienteId ?? this.pazienteId,
      domanda: domanda ?? this.domanda,
      risposta: risposta ?? this.risposta,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (pazienteId.present) {
      map['paziente_id'] = Variable<int>(pazienteId.value);
    }
    if (domanda.present) {
      map['domanda'] = Variable<String>(domanda.value);
    }
    if (risposta.present) {
      map['risposta'] = Variable<bool>(risposta.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RisposteAnamnesiCompanion(')
          ..write('id: $id, ')
          ..write('pazienteId: $pazienteId, ')
          ..write('domanda: $domanda, ')
          ..write('risposta: $risposta')
          ..write(')'))
        .toString();
  }
}

class $CatalogoParametriTable extends CatalogoParametri
    with TableInfo<$CatalogoParametriTable, ParametroCatalogo> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CatalogoParametriTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nomeVisualizzatoMeta =
      const VerificationMeta('nomeVisualizzato');
  @override
  late final GeneratedColumn<String> nomeVisualizzato = GeneratedColumn<String>(
      'nome_visualizzato', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _codiceMeta = const VerificationMeta('codice');
  @override
  late final GeneratedColumn<String> codice = GeneratedColumn<String>(
      'codice', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _unitaMisuraMeta =
      const VerificationMeta('unitaMisura');
  @override
  late final GeneratedColumn<String> unitaMisura = GeneratedColumn<String>(
      'unita_misura', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  late final GeneratedColumnWithTypeConverter<TipoValore, int> tipoValore =
      GeneratedColumn<int>('tipo_valore', aliasedName, false,
              type: DriftSqlType.int, requiredDuringInsert: true)
          .withConverter<TipoValore>(
              $CatalogoParametriTable.$convertertipoValore);
  static const VerificationMeta _etichettaValore1Meta =
      const VerificationMeta('etichettaValore1');
  @override
  late final GeneratedColumn<String> etichettaValore1 = GeneratedColumn<String>(
      'etichetta_valore1', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _etichettaValore2Meta =
      const VerificationMeta('etichettaValore2');
  @override
  late final GeneratedColumn<String> etichettaValore2 = GeneratedColumn<String>(
      'etichetta_valore2', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _sogliaNormaleMinMeta =
      const VerificationMeta('sogliaNormaleMin');
  @override
  late final GeneratedColumn<double> sogliaNormaleMin = GeneratedColumn<double>(
      'soglia_normale_min', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _sogliaNormaleMaxMeta =
      const VerificationMeta('sogliaNormaleMax');
  @override
  late final GeneratedColumn<double> sogliaNormaleMax = GeneratedColumn<double>(
      'soglia_normale_max', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _sogliaAttenzioneMaxMeta =
      const VerificationMeta('sogliaAttenzioneMax');
  @override
  late final GeneratedColumn<double> sogliaAttenzioneMax =
      GeneratedColumn<double>('soglia_attenzione_max', aliasedName, true,
          type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _sogliaAllarmeMaxMeta =
      const VerificationMeta('sogliaAllarmeMax');
  @override
  late final GeneratedColumn<double> sogliaAllarmeMax = GeneratedColumn<double>(
      'soglia_allarme_max', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  @override
  late final GeneratedColumnWithTypeConverter<FonteParametro, int> fonte =
      GeneratedColumn<int>('fonte', aliasedName, false,
              type: DriftSqlType.int, requiredDuringInsert: true)
          .withConverter<FonteParametro>(
              $CatalogoParametriTable.$converterfonte);
  static const VerificationMeta _ordineVisualizzazioneMeta =
      const VerificationMeta('ordineVisualizzazione');
  @override
  late final GeneratedColumn<int> ordineVisualizzazione = GeneratedColumn<int>(
      'ordine_visualizzazione', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _attivoMeta = const VerificationMeta('attivo');
  @override
  late final GeneratedColumn<bool> attivo = GeneratedColumn<bool>(
      'attivo', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("attivo" IN (0, 1))'),
      defaultValue: const Constant(true));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        nomeVisualizzato,
        codice,
        unitaMisura,
        tipoValore,
        etichettaValore1,
        etichettaValore2,
        sogliaNormaleMin,
        sogliaNormaleMax,
        sogliaAttenzioneMax,
        sogliaAllarmeMax,
        fonte,
        ordineVisualizzazione,
        attivo
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'catalogo_parametri';
  @override
  VerificationContext validateIntegrity(Insertable<ParametroCatalogo> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('nome_visualizzato')) {
      context.handle(
          _nomeVisualizzatoMeta,
          nomeVisualizzato.isAcceptableOrUnknown(
              data['nome_visualizzato']!, _nomeVisualizzatoMeta));
    } else if (isInserting) {
      context.missing(_nomeVisualizzatoMeta);
    }
    if (data.containsKey('codice')) {
      context.handle(_codiceMeta,
          codice.isAcceptableOrUnknown(data['codice']!, _codiceMeta));
    } else if (isInserting) {
      context.missing(_codiceMeta);
    }
    if (data.containsKey('unita_misura')) {
      context.handle(
          _unitaMisuraMeta,
          unitaMisura.isAcceptableOrUnknown(
              data['unita_misura']!, _unitaMisuraMeta));
    } else if (isInserting) {
      context.missing(_unitaMisuraMeta);
    }
    if (data.containsKey('etichetta_valore1')) {
      context.handle(
          _etichettaValore1Meta,
          etichettaValore1.isAcceptableOrUnknown(
              data['etichetta_valore1']!, _etichettaValore1Meta));
    } else if (isInserting) {
      context.missing(_etichettaValore1Meta);
    }
    if (data.containsKey('etichetta_valore2')) {
      context.handle(
          _etichettaValore2Meta,
          etichettaValore2.isAcceptableOrUnknown(
              data['etichetta_valore2']!, _etichettaValore2Meta));
    }
    if (data.containsKey('soglia_normale_min')) {
      context.handle(
          _sogliaNormaleMinMeta,
          sogliaNormaleMin.isAcceptableOrUnknown(
              data['soglia_normale_min']!, _sogliaNormaleMinMeta));
    }
    if (data.containsKey('soglia_normale_max')) {
      context.handle(
          _sogliaNormaleMaxMeta,
          sogliaNormaleMax.isAcceptableOrUnknown(
              data['soglia_normale_max']!, _sogliaNormaleMaxMeta));
    }
    if (data.containsKey('soglia_attenzione_max')) {
      context.handle(
          _sogliaAttenzioneMaxMeta,
          sogliaAttenzioneMax.isAcceptableOrUnknown(
              data['soglia_attenzione_max']!, _sogliaAttenzioneMaxMeta));
    }
    if (data.containsKey('soglia_allarme_max')) {
      context.handle(
          _sogliaAllarmeMaxMeta,
          sogliaAllarmeMax.isAcceptableOrUnknown(
              data['soglia_allarme_max']!, _sogliaAllarmeMaxMeta));
    }
    if (data.containsKey('ordine_visualizzazione')) {
      context.handle(
          _ordineVisualizzazioneMeta,
          ordineVisualizzazione.isAcceptableOrUnknown(
              data['ordine_visualizzazione']!, _ordineVisualizzazioneMeta));
    }
    if (data.containsKey('attivo')) {
      context.handle(_attivoMeta,
          attivo.isAcceptableOrUnknown(data['attivo']!, _attivoMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ParametroCatalogo map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ParametroCatalogo(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      nomeVisualizzato: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}nome_visualizzato'])!,
      codice: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}codice'])!,
      unitaMisura: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}unita_misura'])!,
      tipoValore: $CatalogoParametriTable.$convertertipoValore.fromSql(
          attachedDatabase.typeMapping
              .read(DriftSqlType.int, data['${effectivePrefix}tipo_valore'])!),
      etichettaValore1: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}etichetta_valore1'])!,
      etichettaValore2: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}etichetta_valore2']),
      sogliaNormaleMin: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}soglia_normale_min']),
      sogliaNormaleMax: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}soglia_normale_max']),
      sogliaAttenzioneMax: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}soglia_attenzione_max']),
      sogliaAllarmeMax: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}soglia_allarme_max']),
      fonte: $CatalogoParametriTable.$converterfonte.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}fonte'])!),
      ordineVisualizzazione: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}ordine_visualizzazione'])!,
      attivo: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}attivo'])!,
    );
  }

  @override
  $CatalogoParametriTable createAlias(String alias) {
    return $CatalogoParametriTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<TipoValore, int, int> $convertertipoValore =
      const EnumIndexConverter<TipoValore>(TipoValore.values);
  static JsonTypeConverter2<FonteParametro, int, int> $converterfonte =
      const EnumIndexConverter<FonteParametro>(FonteParametro.values);
}

class ParametroCatalogo extends DataClass
    implements Insertable<ParametroCatalogo> {
  final int id;
  final String nomeVisualizzato;
  final String codice;
  final String unitaMisura;
  final TipoValore tipoValore;
  final String etichettaValore1;
  final String? etichettaValore2;
  final double? sogliaNormaleMin;
  final double? sogliaNormaleMax;
  final double? sogliaAttenzioneMax;
  final double? sogliaAllarmeMax;
  final FonteParametro fonte;
  final int ordineVisualizzazione;
  final bool attivo;
  const ParametroCatalogo(
      {required this.id,
      required this.nomeVisualizzato,
      required this.codice,
      required this.unitaMisura,
      required this.tipoValore,
      required this.etichettaValore1,
      this.etichettaValore2,
      this.sogliaNormaleMin,
      this.sogliaNormaleMax,
      this.sogliaAttenzioneMax,
      this.sogliaAllarmeMax,
      required this.fonte,
      required this.ordineVisualizzazione,
      required this.attivo});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['nome_visualizzato'] = Variable<String>(nomeVisualizzato);
    map['codice'] = Variable<String>(codice);
    map['unita_misura'] = Variable<String>(unitaMisura);
    {
      map['tipo_valore'] = Variable<int>(
          $CatalogoParametriTable.$convertertipoValore.toSql(tipoValore));
    }
    map['etichetta_valore1'] = Variable<String>(etichettaValore1);
    if (!nullToAbsent || etichettaValore2 != null) {
      map['etichetta_valore2'] = Variable<String>(etichettaValore2);
    }
    if (!nullToAbsent || sogliaNormaleMin != null) {
      map['soglia_normale_min'] = Variable<double>(sogliaNormaleMin);
    }
    if (!nullToAbsent || sogliaNormaleMax != null) {
      map['soglia_normale_max'] = Variable<double>(sogliaNormaleMax);
    }
    if (!nullToAbsent || sogliaAttenzioneMax != null) {
      map['soglia_attenzione_max'] = Variable<double>(sogliaAttenzioneMax);
    }
    if (!nullToAbsent || sogliaAllarmeMax != null) {
      map['soglia_allarme_max'] = Variable<double>(sogliaAllarmeMax);
    }
    {
      map['fonte'] =
          Variable<int>($CatalogoParametriTable.$converterfonte.toSql(fonte));
    }
    map['ordine_visualizzazione'] = Variable<int>(ordineVisualizzazione);
    map['attivo'] = Variable<bool>(attivo);
    return map;
  }

  CatalogoParametriCompanion toCompanion(bool nullToAbsent) {
    return CatalogoParametriCompanion(
      id: Value(id),
      nomeVisualizzato: Value(nomeVisualizzato),
      codice: Value(codice),
      unitaMisura: Value(unitaMisura),
      tipoValore: Value(tipoValore),
      etichettaValore1: Value(etichettaValore1),
      etichettaValore2: etichettaValore2 == null && nullToAbsent
          ? const Value.absent()
          : Value(etichettaValore2),
      sogliaNormaleMin: sogliaNormaleMin == null && nullToAbsent
          ? const Value.absent()
          : Value(sogliaNormaleMin),
      sogliaNormaleMax: sogliaNormaleMax == null && nullToAbsent
          ? const Value.absent()
          : Value(sogliaNormaleMax),
      sogliaAttenzioneMax: sogliaAttenzioneMax == null && nullToAbsent
          ? const Value.absent()
          : Value(sogliaAttenzioneMax),
      sogliaAllarmeMax: sogliaAllarmeMax == null && nullToAbsent
          ? const Value.absent()
          : Value(sogliaAllarmeMax),
      fonte: Value(fonte),
      ordineVisualizzazione: Value(ordineVisualizzazione),
      attivo: Value(attivo),
    );
  }

  factory ParametroCatalogo.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ParametroCatalogo(
      id: serializer.fromJson<int>(json['id']),
      nomeVisualizzato: serializer.fromJson<String>(json['nomeVisualizzato']),
      codice: serializer.fromJson<String>(json['codice']),
      unitaMisura: serializer.fromJson<String>(json['unitaMisura']),
      tipoValore: $CatalogoParametriTable.$convertertipoValore
          .fromJson(serializer.fromJson<int>(json['tipoValore'])),
      etichettaValore1: serializer.fromJson<String>(json['etichettaValore1']),
      etichettaValore2: serializer.fromJson<String?>(json['etichettaValore2']),
      sogliaNormaleMin: serializer.fromJson<double?>(json['sogliaNormaleMin']),
      sogliaNormaleMax: serializer.fromJson<double?>(json['sogliaNormaleMax']),
      sogliaAttenzioneMax:
          serializer.fromJson<double?>(json['sogliaAttenzioneMax']),
      sogliaAllarmeMax: serializer.fromJson<double?>(json['sogliaAllarmeMax']),
      fonte: $CatalogoParametriTable.$converterfonte
          .fromJson(serializer.fromJson<int>(json['fonte'])),
      ordineVisualizzazione:
          serializer.fromJson<int>(json['ordineVisualizzazione']),
      attivo: serializer.fromJson<bool>(json['attivo']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'nomeVisualizzato': serializer.toJson<String>(nomeVisualizzato),
      'codice': serializer.toJson<String>(codice),
      'unitaMisura': serializer.toJson<String>(unitaMisura),
      'tipoValore': serializer.toJson<int>(
          $CatalogoParametriTable.$convertertipoValore.toJson(tipoValore)),
      'etichettaValore1': serializer.toJson<String>(etichettaValore1),
      'etichettaValore2': serializer.toJson<String?>(etichettaValore2),
      'sogliaNormaleMin': serializer.toJson<double?>(sogliaNormaleMin),
      'sogliaNormaleMax': serializer.toJson<double?>(sogliaNormaleMax),
      'sogliaAttenzioneMax': serializer.toJson<double?>(sogliaAttenzioneMax),
      'sogliaAllarmeMax': serializer.toJson<double?>(sogliaAllarmeMax),
      'fonte': serializer
          .toJson<int>($CatalogoParametriTable.$converterfonte.toJson(fonte)),
      'ordineVisualizzazione': serializer.toJson<int>(ordineVisualizzazione),
      'attivo': serializer.toJson<bool>(attivo),
    };
  }

  ParametroCatalogo copyWith(
          {int? id,
          String? nomeVisualizzato,
          String? codice,
          String? unitaMisura,
          TipoValore? tipoValore,
          String? etichettaValore1,
          Value<String?> etichettaValore2 = const Value.absent(),
          Value<double?> sogliaNormaleMin = const Value.absent(),
          Value<double?> sogliaNormaleMax = const Value.absent(),
          Value<double?> sogliaAttenzioneMax = const Value.absent(),
          Value<double?> sogliaAllarmeMax = const Value.absent(),
          FonteParametro? fonte,
          int? ordineVisualizzazione,
          bool? attivo}) =>
      ParametroCatalogo(
        id: id ?? this.id,
        nomeVisualizzato: nomeVisualizzato ?? this.nomeVisualizzato,
        codice: codice ?? this.codice,
        unitaMisura: unitaMisura ?? this.unitaMisura,
        tipoValore: tipoValore ?? this.tipoValore,
        etichettaValore1: etichettaValore1 ?? this.etichettaValore1,
        etichettaValore2: etichettaValore2.present
            ? etichettaValore2.value
            : this.etichettaValore2,
        sogliaNormaleMin: sogliaNormaleMin.present
            ? sogliaNormaleMin.value
            : this.sogliaNormaleMin,
        sogliaNormaleMax: sogliaNormaleMax.present
            ? sogliaNormaleMax.value
            : this.sogliaNormaleMax,
        sogliaAttenzioneMax: sogliaAttenzioneMax.present
            ? sogliaAttenzioneMax.value
            : this.sogliaAttenzioneMax,
        sogliaAllarmeMax: sogliaAllarmeMax.present
            ? sogliaAllarmeMax.value
            : this.sogliaAllarmeMax,
        fonte: fonte ?? this.fonte,
        ordineVisualizzazione:
            ordineVisualizzazione ?? this.ordineVisualizzazione,
        attivo: attivo ?? this.attivo,
      );
  ParametroCatalogo copyWithCompanion(CatalogoParametriCompanion data) {
    return ParametroCatalogo(
      id: data.id.present ? data.id.value : this.id,
      nomeVisualizzato: data.nomeVisualizzato.present
          ? data.nomeVisualizzato.value
          : this.nomeVisualizzato,
      codice: data.codice.present ? data.codice.value : this.codice,
      unitaMisura:
          data.unitaMisura.present ? data.unitaMisura.value : this.unitaMisura,
      tipoValore:
          data.tipoValore.present ? data.tipoValore.value : this.tipoValore,
      etichettaValore1: data.etichettaValore1.present
          ? data.etichettaValore1.value
          : this.etichettaValore1,
      etichettaValore2: data.etichettaValore2.present
          ? data.etichettaValore2.value
          : this.etichettaValore2,
      sogliaNormaleMin: data.sogliaNormaleMin.present
          ? data.sogliaNormaleMin.value
          : this.sogliaNormaleMin,
      sogliaNormaleMax: data.sogliaNormaleMax.present
          ? data.sogliaNormaleMax.value
          : this.sogliaNormaleMax,
      sogliaAttenzioneMax: data.sogliaAttenzioneMax.present
          ? data.sogliaAttenzioneMax.value
          : this.sogliaAttenzioneMax,
      sogliaAllarmeMax: data.sogliaAllarmeMax.present
          ? data.sogliaAllarmeMax.value
          : this.sogliaAllarmeMax,
      fonte: data.fonte.present ? data.fonte.value : this.fonte,
      ordineVisualizzazione: data.ordineVisualizzazione.present
          ? data.ordineVisualizzazione.value
          : this.ordineVisualizzazione,
      attivo: data.attivo.present ? data.attivo.value : this.attivo,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ParametroCatalogo(')
          ..write('id: $id, ')
          ..write('nomeVisualizzato: $nomeVisualizzato, ')
          ..write('codice: $codice, ')
          ..write('unitaMisura: $unitaMisura, ')
          ..write('tipoValore: $tipoValore, ')
          ..write('etichettaValore1: $etichettaValore1, ')
          ..write('etichettaValore2: $etichettaValore2, ')
          ..write('sogliaNormaleMin: $sogliaNormaleMin, ')
          ..write('sogliaNormaleMax: $sogliaNormaleMax, ')
          ..write('sogliaAttenzioneMax: $sogliaAttenzioneMax, ')
          ..write('sogliaAllarmeMax: $sogliaAllarmeMax, ')
          ..write('fonte: $fonte, ')
          ..write('ordineVisualizzazione: $ordineVisualizzazione, ')
          ..write('attivo: $attivo')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      nomeVisualizzato,
      codice,
      unitaMisura,
      tipoValore,
      etichettaValore1,
      etichettaValore2,
      sogliaNormaleMin,
      sogliaNormaleMax,
      sogliaAttenzioneMax,
      sogliaAllarmeMax,
      fonte,
      ordineVisualizzazione,
      attivo);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ParametroCatalogo &&
          other.id == this.id &&
          other.nomeVisualizzato == this.nomeVisualizzato &&
          other.codice == this.codice &&
          other.unitaMisura == this.unitaMisura &&
          other.tipoValore == this.tipoValore &&
          other.etichettaValore1 == this.etichettaValore1 &&
          other.etichettaValore2 == this.etichettaValore2 &&
          other.sogliaNormaleMin == this.sogliaNormaleMin &&
          other.sogliaNormaleMax == this.sogliaNormaleMax &&
          other.sogliaAttenzioneMax == this.sogliaAttenzioneMax &&
          other.sogliaAllarmeMax == this.sogliaAllarmeMax &&
          other.fonte == this.fonte &&
          other.ordineVisualizzazione == this.ordineVisualizzazione &&
          other.attivo == this.attivo);
}

class CatalogoParametriCompanion extends UpdateCompanion<ParametroCatalogo> {
  final Value<int> id;
  final Value<String> nomeVisualizzato;
  final Value<String> codice;
  final Value<String> unitaMisura;
  final Value<TipoValore> tipoValore;
  final Value<String> etichettaValore1;
  final Value<String?> etichettaValore2;
  final Value<double?> sogliaNormaleMin;
  final Value<double?> sogliaNormaleMax;
  final Value<double?> sogliaAttenzioneMax;
  final Value<double?> sogliaAllarmeMax;
  final Value<FonteParametro> fonte;
  final Value<int> ordineVisualizzazione;
  final Value<bool> attivo;
  const CatalogoParametriCompanion({
    this.id = const Value.absent(),
    this.nomeVisualizzato = const Value.absent(),
    this.codice = const Value.absent(),
    this.unitaMisura = const Value.absent(),
    this.tipoValore = const Value.absent(),
    this.etichettaValore1 = const Value.absent(),
    this.etichettaValore2 = const Value.absent(),
    this.sogliaNormaleMin = const Value.absent(),
    this.sogliaNormaleMax = const Value.absent(),
    this.sogliaAttenzioneMax = const Value.absent(),
    this.sogliaAllarmeMax = const Value.absent(),
    this.fonte = const Value.absent(),
    this.ordineVisualizzazione = const Value.absent(),
    this.attivo = const Value.absent(),
  });
  CatalogoParametriCompanion.insert({
    this.id = const Value.absent(),
    required String nomeVisualizzato,
    required String codice,
    required String unitaMisura,
    required TipoValore tipoValore,
    required String etichettaValore1,
    this.etichettaValore2 = const Value.absent(),
    this.sogliaNormaleMin = const Value.absent(),
    this.sogliaNormaleMax = const Value.absent(),
    this.sogliaAttenzioneMax = const Value.absent(),
    this.sogliaAllarmeMax = const Value.absent(),
    required FonteParametro fonte,
    this.ordineVisualizzazione = const Value.absent(),
    this.attivo = const Value.absent(),
  })  : nomeVisualizzato = Value(nomeVisualizzato),
        codice = Value(codice),
        unitaMisura = Value(unitaMisura),
        tipoValore = Value(tipoValore),
        etichettaValore1 = Value(etichettaValore1),
        fonte = Value(fonte);
  static Insertable<ParametroCatalogo> custom({
    Expression<int>? id,
    Expression<String>? nomeVisualizzato,
    Expression<String>? codice,
    Expression<String>? unitaMisura,
    Expression<int>? tipoValore,
    Expression<String>? etichettaValore1,
    Expression<String>? etichettaValore2,
    Expression<double>? sogliaNormaleMin,
    Expression<double>? sogliaNormaleMax,
    Expression<double>? sogliaAttenzioneMax,
    Expression<double>? sogliaAllarmeMax,
    Expression<int>? fonte,
    Expression<int>? ordineVisualizzazione,
    Expression<bool>? attivo,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nomeVisualizzato != null) 'nome_visualizzato': nomeVisualizzato,
      if (codice != null) 'codice': codice,
      if (unitaMisura != null) 'unita_misura': unitaMisura,
      if (tipoValore != null) 'tipo_valore': tipoValore,
      if (etichettaValore1 != null) 'etichetta_valore1': etichettaValore1,
      if (etichettaValore2 != null) 'etichetta_valore2': etichettaValore2,
      if (sogliaNormaleMin != null) 'soglia_normale_min': sogliaNormaleMin,
      if (sogliaNormaleMax != null) 'soglia_normale_max': sogliaNormaleMax,
      if (sogliaAttenzioneMax != null)
        'soglia_attenzione_max': sogliaAttenzioneMax,
      if (sogliaAllarmeMax != null) 'soglia_allarme_max': sogliaAllarmeMax,
      if (fonte != null) 'fonte': fonte,
      if (ordineVisualizzazione != null)
        'ordine_visualizzazione': ordineVisualizzazione,
      if (attivo != null) 'attivo': attivo,
    });
  }

  CatalogoParametriCompanion copyWith(
      {Value<int>? id,
      Value<String>? nomeVisualizzato,
      Value<String>? codice,
      Value<String>? unitaMisura,
      Value<TipoValore>? tipoValore,
      Value<String>? etichettaValore1,
      Value<String?>? etichettaValore2,
      Value<double?>? sogliaNormaleMin,
      Value<double?>? sogliaNormaleMax,
      Value<double?>? sogliaAttenzioneMax,
      Value<double?>? sogliaAllarmeMax,
      Value<FonteParametro>? fonte,
      Value<int>? ordineVisualizzazione,
      Value<bool>? attivo}) {
    return CatalogoParametriCompanion(
      id: id ?? this.id,
      nomeVisualizzato: nomeVisualizzato ?? this.nomeVisualizzato,
      codice: codice ?? this.codice,
      unitaMisura: unitaMisura ?? this.unitaMisura,
      tipoValore: tipoValore ?? this.tipoValore,
      etichettaValore1: etichettaValore1 ?? this.etichettaValore1,
      etichettaValore2: etichettaValore2 ?? this.etichettaValore2,
      sogliaNormaleMin: sogliaNormaleMin ?? this.sogliaNormaleMin,
      sogliaNormaleMax: sogliaNormaleMax ?? this.sogliaNormaleMax,
      sogliaAttenzioneMax: sogliaAttenzioneMax ?? this.sogliaAttenzioneMax,
      sogliaAllarmeMax: sogliaAllarmeMax ?? this.sogliaAllarmeMax,
      fonte: fonte ?? this.fonte,
      ordineVisualizzazione:
          ordineVisualizzazione ?? this.ordineVisualizzazione,
      attivo: attivo ?? this.attivo,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (nomeVisualizzato.present) {
      map['nome_visualizzato'] = Variable<String>(nomeVisualizzato.value);
    }
    if (codice.present) {
      map['codice'] = Variable<String>(codice.value);
    }
    if (unitaMisura.present) {
      map['unita_misura'] = Variable<String>(unitaMisura.value);
    }
    if (tipoValore.present) {
      map['tipo_valore'] = Variable<int>(
          $CatalogoParametriTable.$convertertipoValore.toSql(tipoValore.value));
    }
    if (etichettaValore1.present) {
      map['etichetta_valore1'] = Variable<String>(etichettaValore1.value);
    }
    if (etichettaValore2.present) {
      map['etichetta_valore2'] = Variable<String>(etichettaValore2.value);
    }
    if (sogliaNormaleMin.present) {
      map['soglia_normale_min'] = Variable<double>(sogliaNormaleMin.value);
    }
    if (sogliaNormaleMax.present) {
      map['soglia_normale_max'] = Variable<double>(sogliaNormaleMax.value);
    }
    if (sogliaAttenzioneMax.present) {
      map['soglia_attenzione_max'] =
          Variable<double>(sogliaAttenzioneMax.value);
    }
    if (sogliaAllarmeMax.present) {
      map['soglia_allarme_max'] = Variable<double>(sogliaAllarmeMax.value);
    }
    if (fonte.present) {
      map['fonte'] = Variable<int>(
          $CatalogoParametriTable.$converterfonte.toSql(fonte.value));
    }
    if (ordineVisualizzazione.present) {
      map['ordine_visualizzazione'] =
          Variable<int>(ordineVisualizzazione.value);
    }
    if (attivo.present) {
      map['attivo'] = Variable<bool>(attivo.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CatalogoParametriCompanion(')
          ..write('id: $id, ')
          ..write('nomeVisualizzato: $nomeVisualizzato, ')
          ..write('codice: $codice, ')
          ..write('unitaMisura: $unitaMisura, ')
          ..write('tipoValore: $tipoValore, ')
          ..write('etichettaValore1: $etichettaValore1, ')
          ..write('etichettaValore2: $etichettaValore2, ')
          ..write('sogliaNormaleMin: $sogliaNormaleMin, ')
          ..write('sogliaNormaleMax: $sogliaNormaleMax, ')
          ..write('sogliaAttenzioneMax: $sogliaAttenzioneMax, ')
          ..write('sogliaAllarmeMax: $sogliaAllarmeMax, ')
          ..write('fonte: $fonte, ')
          ..write('ordineVisualizzazione: $ordineVisualizzazione, ')
          ..write('attivo: $attivo')
          ..write(')'))
        .toString();
  }
}

class $ParametriAbilitatiTable extends ParametriAbilitati
    with TableInfo<$ParametriAbilitatiTable, ParametroAbilitato> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ParametriAbilitatiTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _pazienteIdMeta =
      const VerificationMeta('pazienteId');
  @override
  late final GeneratedColumn<int> pazienteId = GeneratedColumn<int>(
      'paziente_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES pazienti (id)'));
  static const VerificationMeta _parametroIdMeta =
      const VerificationMeta('parametroId');
  @override
  late final GeneratedColumn<int> parametroId = GeneratedColumn<int>(
      'parametro_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES catalogo_parametri (id)'));
  @override
  List<GeneratedColumn> get $columns => [pazienteId, parametroId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'parametri_abilitati';
  @override
  VerificationContext validateIntegrity(Insertable<ParametroAbilitato> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('paziente_id')) {
      context.handle(
          _pazienteIdMeta,
          pazienteId.isAcceptableOrUnknown(
              data['paziente_id']!, _pazienteIdMeta));
    } else if (isInserting) {
      context.missing(_pazienteIdMeta);
    }
    if (data.containsKey('parametro_id')) {
      context.handle(
          _parametroIdMeta,
          parametroId.isAcceptableOrUnknown(
              data['parametro_id']!, _parametroIdMeta));
    } else if (isInserting) {
      context.missing(_parametroIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {pazienteId, parametroId};
  @override
  ParametroAbilitato map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ParametroAbilitato(
      pazienteId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}paziente_id'])!,
      parametroId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}parametro_id'])!,
    );
  }

  @override
  $ParametriAbilitatiTable createAlias(String alias) {
    return $ParametriAbilitatiTable(attachedDatabase, alias);
  }
}

class ParametroAbilitato extends DataClass
    implements Insertable<ParametroAbilitato> {
  final int pazienteId;
  final int parametroId;
  const ParametroAbilitato(
      {required this.pazienteId, required this.parametroId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['paziente_id'] = Variable<int>(pazienteId);
    map['parametro_id'] = Variable<int>(parametroId);
    return map;
  }

  ParametriAbilitatiCompanion toCompanion(bool nullToAbsent) {
    return ParametriAbilitatiCompanion(
      pazienteId: Value(pazienteId),
      parametroId: Value(parametroId),
    );
  }

  factory ParametroAbilitato.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ParametroAbilitato(
      pazienteId: serializer.fromJson<int>(json['pazienteId']),
      parametroId: serializer.fromJson<int>(json['parametroId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'pazienteId': serializer.toJson<int>(pazienteId),
      'parametroId': serializer.toJson<int>(parametroId),
    };
  }

  ParametroAbilitato copyWith({int? pazienteId, int? parametroId}) =>
      ParametroAbilitato(
        pazienteId: pazienteId ?? this.pazienteId,
        parametroId: parametroId ?? this.parametroId,
      );
  ParametroAbilitato copyWithCompanion(ParametriAbilitatiCompanion data) {
    return ParametroAbilitato(
      pazienteId:
          data.pazienteId.present ? data.pazienteId.value : this.pazienteId,
      parametroId:
          data.parametroId.present ? data.parametroId.value : this.parametroId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ParametroAbilitato(')
          ..write('pazienteId: $pazienteId, ')
          ..write('parametroId: $parametroId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(pazienteId, parametroId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ParametroAbilitato &&
          other.pazienteId == this.pazienteId &&
          other.parametroId == this.parametroId);
}

class ParametriAbilitatiCompanion extends UpdateCompanion<ParametroAbilitato> {
  final Value<int> pazienteId;
  final Value<int> parametroId;
  final Value<int> rowid;
  const ParametriAbilitatiCompanion({
    this.pazienteId = const Value.absent(),
    this.parametroId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ParametriAbilitatiCompanion.insert({
    required int pazienteId,
    required int parametroId,
    this.rowid = const Value.absent(),
  })  : pazienteId = Value(pazienteId),
        parametroId = Value(parametroId);
  static Insertable<ParametroAbilitato> custom({
    Expression<int>? pazienteId,
    Expression<int>? parametroId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (pazienteId != null) 'paziente_id': pazienteId,
      if (parametroId != null) 'parametro_id': parametroId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ParametriAbilitatiCompanion copyWith(
      {Value<int>? pazienteId, Value<int>? parametroId, Value<int>? rowid}) {
    return ParametriAbilitatiCompanion(
      pazienteId: pazienteId ?? this.pazienteId,
      parametroId: parametroId ?? this.parametroId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (pazienteId.present) {
      map['paziente_id'] = Variable<int>(pazienteId.value);
    }
    if (parametroId.present) {
      map['parametro_id'] = Variable<int>(parametroId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ParametriAbilitatiCompanion(')
          ..write('pazienteId: $pazienteId, ')
          ..write('parametroId: $parametroId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MisurazioniTable extends Misurazioni
    with TableInfo<$MisurazioniTable, Misurazione> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MisurazioniTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _pazienteIdMeta =
      const VerificationMeta('pazienteId');
  @override
  late final GeneratedColumn<int> pazienteId = GeneratedColumn<int>(
      'paziente_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES pazienti (id)'));
  static const VerificationMeta _parametroIdMeta =
      const VerificationMeta('parametroId');
  @override
  late final GeneratedColumn<int> parametroId = GeneratedColumn<int>(
      'parametro_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES catalogo_parametri (id)'));
  static const VerificationMeta _valore1Meta =
      const VerificationMeta('valore1');
  @override
  late final GeneratedColumn<double> valore1 = GeneratedColumn<double>(
      'valore1', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _valore2Meta =
      const VerificationMeta('valore2');
  @override
  late final GeneratedColumn<double> valore2 = GeneratedColumn<double>(
      'valore2', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _valoreTestoMeta =
      const VerificationMeta('valoreTesto');
  @override
  late final GeneratedColumn<String> valoreTesto = GeneratedColumn<String>(
      'valore_testo', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _dataMeta = const VerificationMeta('data');
  @override
  late final GeneratedColumn<DateTime> data = GeneratedColumn<DateTime>(
      'data', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  late final GeneratedColumnWithTypeConverter<FonteParametro, int>
      fonteEffettiva = GeneratedColumn<int>(
              'fonte_effettiva', aliasedName, false,
              type: DriftSqlType.int, requiredDuringInsert: true)
          .withConverter<FonteParametro>(
              $MisurazioniTable.$converterfonteEffettiva);
  static const VerificationMeta _sincronizzatoMeta =
      const VerificationMeta('sincronizzato');
  @override
  late final GeneratedColumn<bool> sincronizzato = GeneratedColumn<bool>(
      'sincronizzato', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("sincronizzato" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        pazienteId,
        parametroId,
        valore1,
        valore2,
        valoreTesto,
        data,
        fonteEffettiva,
        sincronizzato
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'misurazioni';
  @override
  VerificationContext validateIntegrity(Insertable<Misurazione> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('paziente_id')) {
      context.handle(
          _pazienteIdMeta,
          pazienteId.isAcceptableOrUnknown(
              data['paziente_id']!, _pazienteIdMeta));
    } else if (isInserting) {
      context.missing(_pazienteIdMeta);
    }
    if (data.containsKey('parametro_id')) {
      context.handle(
          _parametroIdMeta,
          parametroId.isAcceptableOrUnknown(
              data['parametro_id']!, _parametroIdMeta));
    } else if (isInserting) {
      context.missing(_parametroIdMeta);
    }
    if (data.containsKey('valore1')) {
      context.handle(_valore1Meta,
          valore1.isAcceptableOrUnknown(data['valore1']!, _valore1Meta));
    }
    if (data.containsKey('valore2')) {
      context.handle(_valore2Meta,
          valore2.isAcceptableOrUnknown(data['valore2']!, _valore2Meta));
    }
    if (data.containsKey('valore_testo')) {
      context.handle(
          _valoreTestoMeta,
          valoreTesto.isAcceptableOrUnknown(
              data['valore_testo']!, _valoreTestoMeta));
    }
    if (data.containsKey('data')) {
      context.handle(
          _dataMeta, this.data.isAcceptableOrUnknown(data['data']!, _dataMeta));
    } else if (isInserting) {
      context.missing(_dataMeta);
    }
    if (data.containsKey('sincronizzato')) {
      context.handle(
          _sincronizzatoMeta,
          sincronizzato.isAcceptableOrUnknown(
              data['sincronizzato']!, _sincronizzatoMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Misurazione map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Misurazione(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      pazienteId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}paziente_id'])!,
      parametroId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}parametro_id'])!,
      valore1: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}valore1']),
      valore2: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}valore2']),
      valoreTesto: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}valore_testo']),
      data: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}data'])!,
      fonteEffettiva: $MisurazioniTable.$converterfonteEffettiva.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.int, data['${effectivePrefix}fonte_effettiva'])!),
      sincronizzato: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}sincronizzato'])!,
    );
  }

  @override
  $MisurazioniTable createAlias(String alias) {
    return $MisurazioniTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<FonteParametro, int, int> $converterfonteEffettiva =
      const EnumIndexConverter<FonteParametro>(FonteParametro.values);
}

class Misurazione extends DataClass implements Insertable<Misurazione> {
  final int id;
  final int pazienteId;
  final int parametroId;
  final double? valore1;
  final double? valore2;
  final String? valoreTesto;
  final DateTime data;
  final FonteParametro fonteEffettiva;
  final bool sincronizzato;
  const Misurazione(
      {required this.id,
      required this.pazienteId,
      required this.parametroId,
      this.valore1,
      this.valore2,
      this.valoreTesto,
      required this.data,
      required this.fonteEffettiva,
      required this.sincronizzato});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['paziente_id'] = Variable<int>(pazienteId);
    map['parametro_id'] = Variable<int>(parametroId);
    if (!nullToAbsent || valore1 != null) {
      map['valore1'] = Variable<double>(valore1);
    }
    if (!nullToAbsent || valore2 != null) {
      map['valore2'] = Variable<double>(valore2);
    }
    if (!nullToAbsent || valoreTesto != null) {
      map['valore_testo'] = Variable<String>(valoreTesto);
    }
    map['data'] = Variable<DateTime>(data);
    {
      map['fonte_effettiva'] = Variable<int>(
          $MisurazioniTable.$converterfonteEffettiva.toSql(fonteEffettiva));
    }
    map['sincronizzato'] = Variable<bool>(sincronizzato);
    return map;
  }

  MisurazioniCompanion toCompanion(bool nullToAbsent) {
    return MisurazioniCompanion(
      id: Value(id),
      pazienteId: Value(pazienteId),
      parametroId: Value(parametroId),
      valore1: valore1 == null && nullToAbsent
          ? const Value.absent()
          : Value(valore1),
      valore2: valore2 == null && nullToAbsent
          ? const Value.absent()
          : Value(valore2),
      valoreTesto: valoreTesto == null && nullToAbsent
          ? const Value.absent()
          : Value(valoreTesto),
      data: Value(data),
      fonteEffettiva: Value(fonteEffettiva),
      sincronizzato: Value(sincronizzato),
    );
  }

  factory Misurazione.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Misurazione(
      id: serializer.fromJson<int>(json['id']),
      pazienteId: serializer.fromJson<int>(json['pazienteId']),
      parametroId: serializer.fromJson<int>(json['parametroId']),
      valore1: serializer.fromJson<double?>(json['valore1']),
      valore2: serializer.fromJson<double?>(json['valore2']),
      valoreTesto: serializer.fromJson<String?>(json['valoreTesto']),
      data: serializer.fromJson<DateTime>(json['data']),
      fonteEffettiva: $MisurazioniTable.$converterfonteEffettiva
          .fromJson(serializer.fromJson<int>(json['fonteEffettiva'])),
      sincronizzato: serializer.fromJson<bool>(json['sincronizzato']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'pazienteId': serializer.toJson<int>(pazienteId),
      'parametroId': serializer.toJson<int>(parametroId),
      'valore1': serializer.toJson<double?>(valore1),
      'valore2': serializer.toJson<double?>(valore2),
      'valoreTesto': serializer.toJson<String?>(valoreTesto),
      'data': serializer.toJson<DateTime>(data),
      'fonteEffettiva': serializer.toJson<int>(
          $MisurazioniTable.$converterfonteEffettiva.toJson(fonteEffettiva)),
      'sincronizzato': serializer.toJson<bool>(sincronizzato),
    };
  }

  Misurazione copyWith(
          {int? id,
          int? pazienteId,
          int? parametroId,
          Value<double?> valore1 = const Value.absent(),
          Value<double?> valore2 = const Value.absent(),
          Value<String?> valoreTesto = const Value.absent(),
          DateTime? data,
          FonteParametro? fonteEffettiva,
          bool? sincronizzato}) =>
      Misurazione(
        id: id ?? this.id,
        pazienteId: pazienteId ?? this.pazienteId,
        parametroId: parametroId ?? this.parametroId,
        valore1: valore1.present ? valore1.value : this.valore1,
        valore2: valore2.present ? valore2.value : this.valore2,
        valoreTesto: valoreTesto.present ? valoreTesto.value : this.valoreTesto,
        data: data ?? this.data,
        fonteEffettiva: fonteEffettiva ?? this.fonteEffettiva,
        sincronizzato: sincronizzato ?? this.sincronizzato,
      );
  Misurazione copyWithCompanion(MisurazioniCompanion data) {
    return Misurazione(
      id: data.id.present ? data.id.value : this.id,
      pazienteId:
          data.pazienteId.present ? data.pazienteId.value : this.pazienteId,
      parametroId:
          data.parametroId.present ? data.parametroId.value : this.parametroId,
      valore1: data.valore1.present ? data.valore1.value : this.valore1,
      valore2: data.valore2.present ? data.valore2.value : this.valore2,
      valoreTesto:
          data.valoreTesto.present ? data.valoreTesto.value : this.valoreTesto,
      data: data.data.present ? data.data.value : this.data,
      fonteEffettiva: data.fonteEffettiva.present
          ? data.fonteEffettiva.value
          : this.fonteEffettiva,
      sincronizzato: data.sincronizzato.present
          ? data.sincronizzato.value
          : this.sincronizzato,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Misurazione(')
          ..write('id: $id, ')
          ..write('pazienteId: $pazienteId, ')
          ..write('parametroId: $parametroId, ')
          ..write('valore1: $valore1, ')
          ..write('valore2: $valore2, ')
          ..write('valoreTesto: $valoreTesto, ')
          ..write('data: $data, ')
          ..write('fonteEffettiva: $fonteEffettiva, ')
          ..write('sincronizzato: $sincronizzato')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, pazienteId, parametroId, valore1, valore2,
      valoreTesto, data, fonteEffettiva, sincronizzato);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Misurazione &&
          other.id == this.id &&
          other.pazienteId == this.pazienteId &&
          other.parametroId == this.parametroId &&
          other.valore1 == this.valore1 &&
          other.valore2 == this.valore2 &&
          other.valoreTesto == this.valoreTesto &&
          other.data == this.data &&
          other.fonteEffettiva == this.fonteEffettiva &&
          other.sincronizzato == this.sincronizzato);
}

class MisurazioniCompanion extends UpdateCompanion<Misurazione> {
  final Value<int> id;
  final Value<int> pazienteId;
  final Value<int> parametroId;
  final Value<double?> valore1;
  final Value<double?> valore2;
  final Value<String?> valoreTesto;
  final Value<DateTime> data;
  final Value<FonteParametro> fonteEffettiva;
  final Value<bool> sincronizzato;
  const MisurazioniCompanion({
    this.id = const Value.absent(),
    this.pazienteId = const Value.absent(),
    this.parametroId = const Value.absent(),
    this.valore1 = const Value.absent(),
    this.valore2 = const Value.absent(),
    this.valoreTesto = const Value.absent(),
    this.data = const Value.absent(),
    this.fonteEffettiva = const Value.absent(),
    this.sincronizzato = const Value.absent(),
  });
  MisurazioniCompanion.insert({
    this.id = const Value.absent(),
    required int pazienteId,
    required int parametroId,
    this.valore1 = const Value.absent(),
    this.valore2 = const Value.absent(),
    this.valoreTesto = const Value.absent(),
    required DateTime data,
    required FonteParametro fonteEffettiva,
    this.sincronizzato = const Value.absent(),
  })  : pazienteId = Value(pazienteId),
        parametroId = Value(parametroId),
        data = Value(data),
        fonteEffettiva = Value(fonteEffettiva);
  static Insertable<Misurazione> custom({
    Expression<int>? id,
    Expression<int>? pazienteId,
    Expression<int>? parametroId,
    Expression<double>? valore1,
    Expression<double>? valore2,
    Expression<String>? valoreTesto,
    Expression<DateTime>? data,
    Expression<int>? fonteEffettiva,
    Expression<bool>? sincronizzato,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (pazienteId != null) 'paziente_id': pazienteId,
      if (parametroId != null) 'parametro_id': parametroId,
      if (valore1 != null) 'valore1': valore1,
      if (valore2 != null) 'valore2': valore2,
      if (valoreTesto != null) 'valore_testo': valoreTesto,
      if (data != null) 'data': data,
      if (fonteEffettiva != null) 'fonte_effettiva': fonteEffettiva,
      if (sincronizzato != null) 'sincronizzato': sincronizzato,
    });
  }

  MisurazioniCompanion copyWith(
      {Value<int>? id,
      Value<int>? pazienteId,
      Value<int>? parametroId,
      Value<double?>? valore1,
      Value<double?>? valore2,
      Value<String?>? valoreTesto,
      Value<DateTime>? data,
      Value<FonteParametro>? fonteEffettiva,
      Value<bool>? sincronizzato}) {
    return MisurazioniCompanion(
      id: id ?? this.id,
      pazienteId: pazienteId ?? this.pazienteId,
      parametroId: parametroId ?? this.parametroId,
      valore1: valore1 ?? this.valore1,
      valore2: valore2 ?? this.valore2,
      valoreTesto: valoreTesto ?? this.valoreTesto,
      data: data ?? this.data,
      fonteEffettiva: fonteEffettiva ?? this.fonteEffettiva,
      sincronizzato: sincronizzato ?? this.sincronizzato,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (pazienteId.present) {
      map['paziente_id'] = Variable<int>(pazienteId.value);
    }
    if (parametroId.present) {
      map['parametro_id'] = Variable<int>(parametroId.value);
    }
    if (valore1.present) {
      map['valore1'] = Variable<double>(valore1.value);
    }
    if (valore2.present) {
      map['valore2'] = Variable<double>(valore2.value);
    }
    if (valoreTesto.present) {
      map['valore_testo'] = Variable<String>(valoreTesto.value);
    }
    if (data.present) {
      map['data'] = Variable<DateTime>(data.value);
    }
    if (fonteEffettiva.present) {
      map['fonte_effettiva'] = Variable<int>($MisurazioniTable
          .$converterfonteEffettiva
          .toSql(fonteEffettiva.value));
    }
    if (sincronizzato.present) {
      map['sincronizzato'] = Variable<bool>(sincronizzato.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MisurazioniCompanion(')
          ..write('id: $id, ')
          ..write('pazienteId: $pazienteId, ')
          ..write('parametroId: $parametroId, ')
          ..write('valore1: $valore1, ')
          ..write('valore2: $valore2, ')
          ..write('valoreTesto: $valoreTesto, ')
          ..write('data: $data, ')
          ..write('fonteEffettiva: $fonteEffettiva, ')
          ..write('sincronizzato: $sincronizzato')
          ..write(')'))
        .toString();
  }
}

class $TemplateRefertiTable extends TemplateReferti
    with TableInfo<$TemplateRefertiTable, TemplateReferto> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TemplateRefertiTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nomeLaboratorioMeta =
      const VerificationMeta('nomeLaboratorio');
  @override
  late final GeneratedColumn<String> nomeLaboratorio = GeneratedColumn<String>(
      'nome_laboratorio', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _parametroIdMeta =
      const VerificationMeta('parametroId');
  @override
  late final GeneratedColumn<int> parametroId = GeneratedColumn<int>(
      'parametro_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES catalogo_parametri (id)'));
  static const VerificationMeta _patternRicercaMeta =
      const VerificationMeta('patternRicerca');
  @override
  late final GeneratedColumn<String> patternRicerca = GeneratedColumn<String>(
      'pattern_ricerca', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _posizioneValoreMeta =
      const VerificationMeta('posizioneValore');
  @override
  late final GeneratedColumn<int> posizioneValore = GeneratedColumn<int>(
      'posizione_valore', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  @override
  List<GeneratedColumn> get $columns =>
      [id, nomeLaboratorio, parametroId, patternRicerca, posizioneValore];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'template_referti';
  @override
  VerificationContext validateIntegrity(Insertable<TemplateReferto> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('nome_laboratorio')) {
      context.handle(
          _nomeLaboratorioMeta,
          nomeLaboratorio.isAcceptableOrUnknown(
              data['nome_laboratorio']!, _nomeLaboratorioMeta));
    } else if (isInserting) {
      context.missing(_nomeLaboratorioMeta);
    }
    if (data.containsKey('parametro_id')) {
      context.handle(
          _parametroIdMeta,
          parametroId.isAcceptableOrUnknown(
              data['parametro_id']!, _parametroIdMeta));
    } else if (isInserting) {
      context.missing(_parametroIdMeta);
    }
    if (data.containsKey('pattern_ricerca')) {
      context.handle(
          _patternRicercaMeta,
          patternRicerca.isAcceptableOrUnknown(
              data['pattern_ricerca']!, _patternRicercaMeta));
    } else if (isInserting) {
      context.missing(_patternRicercaMeta);
    }
    if (data.containsKey('posizione_valore')) {
      context.handle(
          _posizioneValoreMeta,
          posizioneValore.isAcceptableOrUnknown(
              data['posizione_valore']!, _posizioneValoreMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TemplateReferto map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TemplateReferto(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      nomeLaboratorio: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}nome_laboratorio'])!,
      parametroId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}parametro_id'])!,
      patternRicerca: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}pattern_ricerca'])!,
      posizioneValore: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}posizione_valore'])!,
    );
  }

  @override
  $TemplateRefertiTable createAlias(String alias) {
    return $TemplateRefertiTable(attachedDatabase, alias);
  }
}

class TemplateReferto extends DataClass implements Insertable<TemplateReferto> {
  final int id;
  final String nomeLaboratorio;
  final int parametroId;
  final String patternRicerca;
  final int posizioneValore;
  const TemplateReferto(
      {required this.id,
      required this.nomeLaboratorio,
      required this.parametroId,
      required this.patternRicerca,
      required this.posizioneValore});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['nome_laboratorio'] = Variable<String>(nomeLaboratorio);
    map['parametro_id'] = Variable<int>(parametroId);
    map['pattern_ricerca'] = Variable<String>(patternRicerca);
    map['posizione_valore'] = Variable<int>(posizioneValore);
    return map;
  }

  TemplateRefertiCompanion toCompanion(bool nullToAbsent) {
    return TemplateRefertiCompanion(
      id: Value(id),
      nomeLaboratorio: Value(nomeLaboratorio),
      parametroId: Value(parametroId),
      patternRicerca: Value(patternRicerca),
      posizioneValore: Value(posizioneValore),
    );
  }

  factory TemplateReferto.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TemplateReferto(
      id: serializer.fromJson<int>(json['id']),
      nomeLaboratorio: serializer.fromJson<String>(json['nomeLaboratorio']),
      parametroId: serializer.fromJson<int>(json['parametroId']),
      patternRicerca: serializer.fromJson<String>(json['patternRicerca']),
      posizioneValore: serializer.fromJson<int>(json['posizioneValore']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'nomeLaboratorio': serializer.toJson<String>(nomeLaboratorio),
      'parametroId': serializer.toJson<int>(parametroId),
      'patternRicerca': serializer.toJson<String>(patternRicerca),
      'posizioneValore': serializer.toJson<int>(posizioneValore),
    };
  }

  TemplateReferto copyWith(
          {int? id,
          String? nomeLaboratorio,
          int? parametroId,
          String? patternRicerca,
          int? posizioneValore}) =>
      TemplateReferto(
        id: id ?? this.id,
        nomeLaboratorio: nomeLaboratorio ?? this.nomeLaboratorio,
        parametroId: parametroId ?? this.parametroId,
        patternRicerca: patternRicerca ?? this.patternRicerca,
        posizioneValore: posizioneValore ?? this.posizioneValore,
      );
  TemplateReferto copyWithCompanion(TemplateRefertiCompanion data) {
    return TemplateReferto(
      id: data.id.present ? data.id.value : this.id,
      nomeLaboratorio: data.nomeLaboratorio.present
          ? data.nomeLaboratorio.value
          : this.nomeLaboratorio,
      parametroId:
          data.parametroId.present ? data.parametroId.value : this.parametroId,
      patternRicerca: data.patternRicerca.present
          ? data.patternRicerca.value
          : this.patternRicerca,
      posizioneValore: data.posizioneValore.present
          ? data.posizioneValore.value
          : this.posizioneValore,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TemplateReferto(')
          ..write('id: $id, ')
          ..write('nomeLaboratorio: $nomeLaboratorio, ')
          ..write('parametroId: $parametroId, ')
          ..write('patternRicerca: $patternRicerca, ')
          ..write('posizioneValore: $posizioneValore')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, nomeLaboratorio, parametroId, patternRicerca, posizioneValore);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TemplateReferto &&
          other.id == this.id &&
          other.nomeLaboratorio == this.nomeLaboratorio &&
          other.parametroId == this.parametroId &&
          other.patternRicerca == this.patternRicerca &&
          other.posizioneValore == this.posizioneValore);
}

class TemplateRefertiCompanion extends UpdateCompanion<TemplateReferto> {
  final Value<int> id;
  final Value<String> nomeLaboratorio;
  final Value<int> parametroId;
  final Value<String> patternRicerca;
  final Value<int> posizioneValore;
  const TemplateRefertiCompanion({
    this.id = const Value.absent(),
    this.nomeLaboratorio = const Value.absent(),
    this.parametroId = const Value.absent(),
    this.patternRicerca = const Value.absent(),
    this.posizioneValore = const Value.absent(),
  });
  TemplateRefertiCompanion.insert({
    this.id = const Value.absent(),
    required String nomeLaboratorio,
    required int parametroId,
    required String patternRicerca,
    this.posizioneValore = const Value.absent(),
  })  : nomeLaboratorio = Value(nomeLaboratorio),
        parametroId = Value(parametroId),
        patternRicerca = Value(patternRicerca);
  static Insertable<TemplateReferto> custom({
    Expression<int>? id,
    Expression<String>? nomeLaboratorio,
    Expression<int>? parametroId,
    Expression<String>? patternRicerca,
    Expression<int>? posizioneValore,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nomeLaboratorio != null) 'nome_laboratorio': nomeLaboratorio,
      if (parametroId != null) 'parametro_id': parametroId,
      if (patternRicerca != null) 'pattern_ricerca': patternRicerca,
      if (posizioneValore != null) 'posizione_valore': posizioneValore,
    });
  }

  TemplateRefertiCompanion copyWith(
      {Value<int>? id,
      Value<String>? nomeLaboratorio,
      Value<int>? parametroId,
      Value<String>? patternRicerca,
      Value<int>? posizioneValore}) {
    return TemplateRefertiCompanion(
      id: id ?? this.id,
      nomeLaboratorio: nomeLaboratorio ?? this.nomeLaboratorio,
      parametroId: parametroId ?? this.parametroId,
      patternRicerca: patternRicerca ?? this.patternRicerca,
      posizioneValore: posizioneValore ?? this.posizioneValore,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (nomeLaboratorio.present) {
      map['nome_laboratorio'] = Variable<String>(nomeLaboratorio.value);
    }
    if (parametroId.present) {
      map['parametro_id'] = Variable<int>(parametroId.value);
    }
    if (patternRicerca.present) {
      map['pattern_ricerca'] = Variable<String>(patternRicerca.value);
    }
    if (posizioneValore.present) {
      map['posizione_valore'] = Variable<int>(posizioneValore.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TemplateRefertiCompanion(')
          ..write('id: $id, ')
          ..write('nomeLaboratorio: $nomeLaboratorio, ')
          ..write('parametroId: $parametroId, ')
          ..write('patternRicerca: $patternRicerca, ')
          ..write('posizioneValore: $posizioneValore')
          ..write(')'))
        .toString();
  }
}

class $TerapieTable extends Terapie with TableInfo<$TerapieTable, Terapia> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TerapieTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _pazienteIdMeta =
      const VerificationMeta('pazienteId');
  @override
  late final GeneratedColumn<int> pazienteId = GeneratedColumn<int>(
      'paziente_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES pazienti (id)'));
  static const VerificationMeta _patologiaIdMeta =
      const VerificationMeta('patologiaId');
  @override
  late final GeneratedColumn<int> patologiaId = GeneratedColumn<int>(
      'patologia_id', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES patologie (id)'));
  static const VerificationMeta _nomeFarmacoMeta =
      const VerificationMeta('nomeFarmaco');
  @override
  late final GeneratedColumn<String> nomeFarmaco = GeneratedColumn<String>(
      'nome_farmaco', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _dosaggioMeta =
      const VerificationMeta('dosaggio');
  @override
  late final GeneratedColumn<String> dosaggio = GeneratedColumn<String>(
      'dosaggio', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  late final GeneratedColumnWithTypeConverter<PrioritaTerapia, int> priorita =
      GeneratedColumn<int>('priorita', aliasedName, false,
              type: DriftSqlType.int, requiredDuringInsert: true)
          .withConverter<PrioritaTerapia>($TerapieTable.$converterpriorita);
  static const VerificationMeta _fotoBlisterPathMeta =
      const VerificationMeta('fotoBlisterPath');
  @override
  late final GeneratedColumn<String> fotoBlisterPath = GeneratedColumn<String>(
      'foto_blister_path', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _attivaMeta = const VerificationMeta('attiva');
  @override
  late final GeneratedColumn<bool> attiva = GeneratedColumn<bool>(
      'attiva', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("attiva" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _dataInizioMeta =
      const VerificationMeta('dataInizio');
  @override
  late final GeneratedColumn<DateTime> dataInizio = GeneratedColumn<DateTime>(
      'data_inizio', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _dataFineMeta =
      const VerificationMeta('dataFine');
  @override
  late final GeneratedColumn<DateTime> dataFine = GeneratedColumn<DateTime>(
      'data_fine', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
      'note', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        pazienteId,
        patologiaId,
        nomeFarmaco,
        dosaggio,
        priorita,
        fotoBlisterPath,
        attiva,
        dataInizio,
        dataFine,
        note
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'terapie';
  @override
  VerificationContext validateIntegrity(Insertable<Terapia> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('paziente_id')) {
      context.handle(
          _pazienteIdMeta,
          pazienteId.isAcceptableOrUnknown(
              data['paziente_id']!, _pazienteIdMeta));
    } else if (isInserting) {
      context.missing(_pazienteIdMeta);
    }
    if (data.containsKey('patologia_id')) {
      context.handle(
          _patologiaIdMeta,
          patologiaId.isAcceptableOrUnknown(
              data['patologia_id']!, _patologiaIdMeta));
    }
    if (data.containsKey('nome_farmaco')) {
      context.handle(
          _nomeFarmacoMeta,
          nomeFarmaco.isAcceptableOrUnknown(
              data['nome_farmaco']!, _nomeFarmacoMeta));
    } else if (isInserting) {
      context.missing(_nomeFarmacoMeta);
    }
    if (data.containsKey('dosaggio')) {
      context.handle(_dosaggioMeta,
          dosaggio.isAcceptableOrUnknown(data['dosaggio']!, _dosaggioMeta));
    }
    if (data.containsKey('foto_blister_path')) {
      context.handle(
          _fotoBlisterPathMeta,
          fotoBlisterPath.isAcceptableOrUnknown(
              data['foto_blister_path']!, _fotoBlisterPathMeta));
    }
    if (data.containsKey('attiva')) {
      context.handle(_attivaMeta,
          attiva.isAcceptableOrUnknown(data['attiva']!, _attivaMeta));
    }
    if (data.containsKey('data_inizio')) {
      context.handle(
          _dataInizioMeta,
          dataInizio.isAcceptableOrUnknown(
              data['data_inizio']!, _dataInizioMeta));
    } else if (isInserting) {
      context.missing(_dataInizioMeta);
    }
    if (data.containsKey('data_fine')) {
      context.handle(_dataFineMeta,
          dataFine.isAcceptableOrUnknown(data['data_fine']!, _dataFineMeta));
    }
    if (data.containsKey('note')) {
      context.handle(
          _noteMeta, note.isAcceptableOrUnknown(data['note']!, _noteMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Terapia map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Terapia(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      pazienteId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}paziente_id'])!,
      patologiaId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}patologia_id']),
      nomeFarmaco: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}nome_farmaco'])!,
      dosaggio: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}dosaggio']),
      priorita: $TerapieTable.$converterpriorita.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}priorita'])!),
      fotoBlisterPath: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}foto_blister_path']),
      attiva: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}attiva'])!,
      dataInizio: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}data_inizio'])!,
      dataFine: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}data_fine']),
      note: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}note']),
    );
  }

  @override
  $TerapieTable createAlias(String alias) {
    return $TerapieTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<PrioritaTerapia, int, int> $converterpriorita =
      const EnumIndexConverter<PrioritaTerapia>(PrioritaTerapia.values);
}

class Terapia extends DataClass implements Insertable<Terapia> {
  final int id;
  final int pazienteId;
  final int? patologiaId;
  final String nomeFarmaco;
  final String? dosaggio;
  final PrioritaTerapia priorita;
  final String? fotoBlisterPath;
  final bool attiva;
  final DateTime dataInizio;
  final DateTime? dataFine;
  final String? note;
  const Terapia(
      {required this.id,
      required this.pazienteId,
      this.patologiaId,
      required this.nomeFarmaco,
      this.dosaggio,
      required this.priorita,
      this.fotoBlisterPath,
      required this.attiva,
      required this.dataInizio,
      this.dataFine,
      this.note});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['paziente_id'] = Variable<int>(pazienteId);
    if (!nullToAbsent || patologiaId != null) {
      map['patologia_id'] = Variable<int>(patologiaId);
    }
    map['nome_farmaco'] = Variable<String>(nomeFarmaco);
    if (!nullToAbsent || dosaggio != null) {
      map['dosaggio'] = Variable<String>(dosaggio);
    }
    {
      map['priorita'] =
          Variable<int>($TerapieTable.$converterpriorita.toSql(priorita));
    }
    if (!nullToAbsent || fotoBlisterPath != null) {
      map['foto_blister_path'] = Variable<String>(fotoBlisterPath);
    }
    map['attiva'] = Variable<bool>(attiva);
    map['data_inizio'] = Variable<DateTime>(dataInizio);
    if (!nullToAbsent || dataFine != null) {
      map['data_fine'] = Variable<DateTime>(dataFine);
    }
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    return map;
  }

  TerapieCompanion toCompanion(bool nullToAbsent) {
    return TerapieCompanion(
      id: Value(id),
      pazienteId: Value(pazienteId),
      patologiaId: patologiaId == null && nullToAbsent
          ? const Value.absent()
          : Value(patologiaId),
      nomeFarmaco: Value(nomeFarmaco),
      dosaggio: dosaggio == null && nullToAbsent
          ? const Value.absent()
          : Value(dosaggio),
      priorita: Value(priorita),
      fotoBlisterPath: fotoBlisterPath == null && nullToAbsent
          ? const Value.absent()
          : Value(fotoBlisterPath),
      attiva: Value(attiva),
      dataInizio: Value(dataInizio),
      dataFine: dataFine == null && nullToAbsent
          ? const Value.absent()
          : Value(dataFine),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
    );
  }

  factory Terapia.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Terapia(
      id: serializer.fromJson<int>(json['id']),
      pazienteId: serializer.fromJson<int>(json['pazienteId']),
      patologiaId: serializer.fromJson<int?>(json['patologiaId']),
      nomeFarmaco: serializer.fromJson<String>(json['nomeFarmaco']),
      dosaggio: serializer.fromJson<String?>(json['dosaggio']),
      priorita: $TerapieTable.$converterpriorita
          .fromJson(serializer.fromJson<int>(json['priorita'])),
      fotoBlisterPath: serializer.fromJson<String?>(json['fotoBlisterPath']),
      attiva: serializer.fromJson<bool>(json['attiva']),
      dataInizio: serializer.fromJson<DateTime>(json['dataInizio']),
      dataFine: serializer.fromJson<DateTime?>(json['dataFine']),
      note: serializer.fromJson<String?>(json['note']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'pazienteId': serializer.toJson<int>(pazienteId),
      'patologiaId': serializer.toJson<int?>(patologiaId),
      'nomeFarmaco': serializer.toJson<String>(nomeFarmaco),
      'dosaggio': serializer.toJson<String?>(dosaggio),
      'priorita': serializer
          .toJson<int>($TerapieTable.$converterpriorita.toJson(priorita)),
      'fotoBlisterPath': serializer.toJson<String?>(fotoBlisterPath),
      'attiva': serializer.toJson<bool>(attiva),
      'dataInizio': serializer.toJson<DateTime>(dataInizio),
      'dataFine': serializer.toJson<DateTime?>(dataFine),
      'note': serializer.toJson<String?>(note),
    };
  }

  Terapia copyWith(
          {int? id,
          int? pazienteId,
          Value<int?> patologiaId = const Value.absent(),
          String? nomeFarmaco,
          Value<String?> dosaggio = const Value.absent(),
          PrioritaTerapia? priorita,
          Value<String?> fotoBlisterPath = const Value.absent(),
          bool? attiva,
          DateTime? dataInizio,
          Value<DateTime?> dataFine = const Value.absent(),
          Value<String?> note = const Value.absent()}) =>
      Terapia(
        id: id ?? this.id,
        pazienteId: pazienteId ?? this.pazienteId,
        patologiaId: patologiaId.present ? patologiaId.value : this.patologiaId,
        nomeFarmaco: nomeFarmaco ?? this.nomeFarmaco,
        dosaggio: dosaggio.present ? dosaggio.value : this.dosaggio,
        priorita: priorita ?? this.priorita,
        fotoBlisterPath: fotoBlisterPath.present
            ? fotoBlisterPath.value
            : this.fotoBlisterPath,
        attiva: attiva ?? this.attiva,
        dataInizio: dataInizio ?? this.dataInizio,
        dataFine: dataFine.present ? dataFine.value : this.dataFine,
        note: note.present ? note.value : this.note,
      );
  Terapia copyWithCompanion(TerapieCompanion data) {
    return Terapia(
      id: data.id.present ? data.id.value : this.id,
      pazienteId:
          data.pazienteId.present ? data.pazienteId.value : this.pazienteId,
      patologiaId:
          data.patologiaId.present ? data.patologiaId.value : this.patologiaId,
      nomeFarmaco:
          data.nomeFarmaco.present ? data.nomeFarmaco.value : this.nomeFarmaco,
      dosaggio: data.dosaggio.present ? data.dosaggio.value : this.dosaggio,
      priorita: data.priorita.present ? data.priorita.value : this.priorita,
      fotoBlisterPath: data.fotoBlisterPath.present
          ? data.fotoBlisterPath.value
          : this.fotoBlisterPath,
      attiva: data.attiva.present ? data.attiva.value : this.attiva,
      dataInizio:
          data.dataInizio.present ? data.dataInizio.value : this.dataInizio,
      dataFine: data.dataFine.present ? data.dataFine.value : this.dataFine,
      note: data.note.present ? data.note.value : this.note,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Terapia(')
          ..write('id: $id, ')
          ..write('pazienteId: $pazienteId, ')
          ..write('patologiaId: $patologiaId, ')
          ..write('nomeFarmaco: $nomeFarmaco, ')
          ..write('dosaggio: $dosaggio, ')
          ..write('priorita: $priorita, ')
          ..write('fotoBlisterPath: $fotoBlisterPath, ')
          ..write('attiva: $attiva, ')
          ..write('dataInizio: $dataInizio, ')
          ..write('dataFine: $dataFine, ')
          ..write('note: $note')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, pazienteId, patologiaId, nomeFarmaco,
      dosaggio, priorita, fotoBlisterPath, attiva, dataInizio, dataFine, note);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Terapia &&
          other.id == this.id &&
          other.pazienteId == this.pazienteId &&
          other.patologiaId == this.patologiaId &&
          other.nomeFarmaco == this.nomeFarmaco &&
          other.dosaggio == this.dosaggio &&
          other.priorita == this.priorita &&
          other.fotoBlisterPath == this.fotoBlisterPath &&
          other.attiva == this.attiva &&
          other.dataInizio == this.dataInizio &&
          other.dataFine == this.dataFine &&
          other.note == this.note);
}

class TerapieCompanion extends UpdateCompanion<Terapia> {
  final Value<int> id;
  final Value<int> pazienteId;
  final Value<int?> patologiaId;
  final Value<String> nomeFarmaco;
  final Value<String?> dosaggio;
  final Value<PrioritaTerapia> priorita;
  final Value<String?> fotoBlisterPath;
  final Value<bool> attiva;
  final Value<DateTime> dataInizio;
  final Value<DateTime?> dataFine;
  final Value<String?> note;
  const TerapieCompanion({
    this.id = const Value.absent(),
    this.pazienteId = const Value.absent(),
    this.patologiaId = const Value.absent(),
    this.nomeFarmaco = const Value.absent(),
    this.dosaggio = const Value.absent(),
    this.priorita = const Value.absent(),
    this.fotoBlisterPath = const Value.absent(),
    this.attiva = const Value.absent(),
    this.dataInizio = const Value.absent(),
    this.dataFine = const Value.absent(),
    this.note = const Value.absent(),
  });
  TerapieCompanion.insert({
    this.id = const Value.absent(),
    required int pazienteId,
    this.patologiaId = const Value.absent(),
    required String nomeFarmaco,
    this.dosaggio = const Value.absent(),
    required PrioritaTerapia priorita,
    this.fotoBlisterPath = const Value.absent(),
    this.attiva = const Value.absent(),
    required DateTime dataInizio,
    this.dataFine = const Value.absent(),
    this.note = const Value.absent(),
  })  : pazienteId = Value(pazienteId),
        nomeFarmaco = Value(nomeFarmaco),
        priorita = Value(priorita),
        dataInizio = Value(dataInizio);
  static Insertable<Terapia> custom({
    Expression<int>? id,
    Expression<int>? pazienteId,
    Expression<int>? patologiaId,
    Expression<String>? nomeFarmaco,
    Expression<String>? dosaggio,
    Expression<int>? priorita,
    Expression<String>? fotoBlisterPath,
    Expression<bool>? attiva,
    Expression<DateTime>? dataInizio,
    Expression<DateTime>? dataFine,
    Expression<String>? note,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (pazienteId != null) 'paziente_id': pazienteId,
      if (patologiaId != null) 'patologia_id': patologiaId,
      if (nomeFarmaco != null) 'nome_farmaco': nomeFarmaco,
      if (dosaggio != null) 'dosaggio': dosaggio,
      if (priorita != null) 'priorita': priorita,
      if (fotoBlisterPath != null) 'foto_blister_path': fotoBlisterPath,
      if (attiva != null) 'attiva': attiva,
      if (dataInizio != null) 'data_inizio': dataInizio,
      if (dataFine != null) 'data_fine': dataFine,
      if (note != null) 'note': note,
    });
  }

  TerapieCompanion copyWith(
      {Value<int>? id,
      Value<int>? pazienteId,
      Value<int?>? patologiaId,
      Value<String>? nomeFarmaco,
      Value<String?>? dosaggio,
      Value<PrioritaTerapia>? priorita,
      Value<String?>? fotoBlisterPath,
      Value<bool>? attiva,
      Value<DateTime>? dataInizio,
      Value<DateTime?>? dataFine,
      Value<String?>? note}) {
    return TerapieCompanion(
      id: id ?? this.id,
      pazienteId: pazienteId ?? this.pazienteId,
      patologiaId: patologiaId ?? this.patologiaId,
      nomeFarmaco: nomeFarmaco ?? this.nomeFarmaco,
      dosaggio: dosaggio ?? this.dosaggio,
      priorita: priorita ?? this.priorita,
      fotoBlisterPath: fotoBlisterPath ?? this.fotoBlisterPath,
      attiva: attiva ?? this.attiva,
      dataInizio: dataInizio ?? this.dataInizio,
      dataFine: dataFine ?? this.dataFine,
      note: note ?? this.note,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (pazienteId.present) {
      map['paziente_id'] = Variable<int>(pazienteId.value);
    }
    if (patologiaId.present) {
      map['patologia_id'] = Variable<int>(patologiaId.value);
    }
    if (nomeFarmaco.present) {
      map['nome_farmaco'] = Variable<String>(nomeFarmaco.value);
    }
    if (dosaggio.present) {
      map['dosaggio'] = Variable<String>(dosaggio.value);
    }
    if (priorita.present) {
      map['priorita'] =
          Variable<int>($TerapieTable.$converterpriorita.toSql(priorita.value));
    }
    if (fotoBlisterPath.present) {
      map['foto_blister_path'] = Variable<String>(fotoBlisterPath.value);
    }
    if (attiva.present) {
      map['attiva'] = Variable<bool>(attiva.value);
    }
    if (dataInizio.present) {
      map['data_inizio'] = Variable<DateTime>(dataInizio.value);
    }
    if (dataFine.present) {
      map['data_fine'] = Variable<DateTime>(dataFine.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TerapieCompanion(')
          ..write('id: $id, ')
          ..write('pazienteId: $pazienteId, ')
          ..write('patologiaId: $patologiaId, ')
          ..write('nomeFarmaco: $nomeFarmaco, ')
          ..write('dosaggio: $dosaggio, ')
          ..write('priorita: $priorita, ')
          ..write('fotoBlisterPath: $fotoBlisterPath, ')
          ..write('attiva: $attiva, ')
          ..write('dataInizio: $dataInizio, ')
          ..write('dataFine: $dataFine, ')
          ..write('note: $note')
          ..write(')'))
        .toString();
  }
}

class $OrariTerapiaTable extends OrariTerapia
    with TableInfo<$OrariTerapiaTable, OrarioTerapia> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $OrariTerapiaTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _terapiaIdMeta =
      const VerificationMeta('terapiaId');
  @override
  late final GeneratedColumn<int> terapiaId = GeneratedColumn<int>(
      'terapia_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES terapie (id)'));
  static const VerificationMeta _oraMeta = const VerificationMeta('ora');
  @override
  late final GeneratedColumn<String> ora = GeneratedColumn<String>(
      'ora', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, terapiaId, ora];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'orari_terapia';
  @override
  VerificationContext validateIntegrity(Insertable<OrarioTerapia> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('terapia_id')) {
      context.handle(_terapiaIdMeta,
          terapiaId.isAcceptableOrUnknown(data['terapia_id']!, _terapiaIdMeta));
    } else if (isInserting) {
      context.missing(_terapiaIdMeta);
    }
    if (data.containsKey('ora')) {
      context.handle(
          _oraMeta, ora.isAcceptableOrUnknown(data['ora']!, _oraMeta));
    } else if (isInserting) {
      context.missing(_oraMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  OrarioTerapia map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return OrarioTerapia(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      terapiaId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}terapia_id'])!,
      ora: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}ora'])!,
    );
  }

  @override
  $OrariTerapiaTable createAlias(String alias) {
    return $OrariTerapiaTable(attachedDatabase, alias);
  }
}

class OrarioTerapia extends DataClass implements Insertable<OrarioTerapia> {
  final int id;
  final int terapiaId;
  final String ora;
  const OrarioTerapia(
      {required this.id, required this.terapiaId, required this.ora});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['terapia_id'] = Variable<int>(terapiaId);
    map['ora'] = Variable<String>(ora);
    return map;
  }

  OrariTerapiaCompanion toCompanion(bool nullToAbsent) {
    return OrariTerapiaCompanion(
      id: Value(id),
      terapiaId: Value(terapiaId),
      ora: Value(ora),
    );
  }

  factory OrarioTerapia.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return OrarioTerapia(
      id: serializer.fromJson<int>(json['id']),
      terapiaId: serializer.fromJson<int>(json['terapiaId']),
      ora: serializer.fromJson<String>(json['ora']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'terapiaId': serializer.toJson<int>(terapiaId),
      'ora': serializer.toJson<String>(ora),
    };
  }

  OrarioTerapia copyWith({int? id, int? terapiaId, String? ora}) =>
      OrarioTerapia(
        id: id ?? this.id,
        terapiaId: terapiaId ?? this.terapiaId,
        ora: ora ?? this.ora,
      );
  OrarioTerapia copyWithCompanion(OrariTerapiaCompanion data) {
    return OrarioTerapia(
      id: data.id.present ? data.id.value : this.id,
      terapiaId: data.terapiaId.present ? data.terapiaId.value : this.terapiaId,
      ora: data.ora.present ? data.ora.value : this.ora,
    );
  }

  @override
  String toString() {
    return (StringBuffer('OrarioTerapia(')
          ..write('id: $id, ')
          ..write('terapiaId: $terapiaId, ')
          ..write('ora: $ora')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, terapiaId, ora);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is OrarioTerapia &&
          other.id == this.id &&
          other.terapiaId == this.terapiaId &&
          other.ora == this.ora);
}

class OrariTerapiaCompanion extends UpdateCompanion<OrarioTerapia> {
  final Value<int> id;
  final Value<int> terapiaId;
  final Value<String> ora;
  const OrariTerapiaCompanion({
    this.id = const Value.absent(),
    this.terapiaId = const Value.absent(),
    this.ora = const Value.absent(),
  });
  OrariTerapiaCompanion.insert({
    this.id = const Value.absent(),
    required int terapiaId,
    required String ora,
  })  : terapiaId = Value(terapiaId),
        ora = Value(ora);
  static Insertable<OrarioTerapia> custom({
    Expression<int>? id,
    Expression<int>? terapiaId,
    Expression<String>? ora,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (terapiaId != null) 'terapia_id': terapiaId,
      if (ora != null) 'ora': ora,
    });
  }

  OrariTerapiaCompanion copyWith(
      {Value<int>? id, Value<int>? terapiaId, Value<String>? ora}) {
    return OrariTerapiaCompanion(
      id: id ?? this.id,
      terapiaId: terapiaId ?? this.terapiaId,
      ora: ora ?? this.ora,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (terapiaId.present) {
      map['terapia_id'] = Variable<int>(terapiaId.value);
    }
    if (ora.present) {
      map['ora'] = Variable<String>(ora.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('OrariTerapiaCompanion(')
          ..write('id: $id, ')
          ..write('terapiaId: $terapiaId, ')
          ..write('ora: $ora')
          ..write(')'))
        .toString();
  }
}

class $AssunzioniTable extends Assunzioni
    with TableInfo<$AssunzioniTable, Assunzione> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AssunzioniTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _terapiaIdMeta =
      const VerificationMeta('terapiaId');
  @override
  late final GeneratedColumn<int> terapiaId = GeneratedColumn<int>(
      'terapia_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES terapie (id)'));
  static const VerificationMeta _orarioIdMeta =
      const VerificationMeta('orarioId');
  @override
  late final GeneratedColumn<int> orarioId = GeneratedColumn<int>(
      'orario_id', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES orari_terapia (id)'));
  static const VerificationMeta _dataOraPrevistaMeta =
      const VerificationMeta('dataOraPrevista');
  @override
  late final GeneratedColumn<DateTime> dataOraPrevista =
      GeneratedColumn<DateTime>('data_ora_prevista', aliasedName, false,
          type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _dataOraRegistrazioneMeta =
      const VerificationMeta('dataOraRegistrazione');
  @override
  late final GeneratedColumn<DateTime> dataOraRegistrazione =
      GeneratedColumn<DateTime>('data_ora_registrazione', aliasedName, true,
          type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  late final GeneratedColumnWithTypeConverter<StatoAssunzione, int> stato =
      GeneratedColumn<int>('stato', aliasedName, false,
              type: DriftSqlType.int, requiredDuringInsert: true)
          .withConverter<StatoAssunzione>($AssunzioniTable.$converterstato);
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
      'note', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _sincronizzatoMeta =
      const VerificationMeta('sincronizzato');
  @override
  late final GeneratedColumn<bool> sincronizzato = GeneratedColumn<bool>(
      'sincronizzato', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("sincronizzato" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        terapiaId,
        orarioId,
        dataOraPrevista,
        dataOraRegistrazione,
        stato,
        note,
        sincronizzato
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'assunzioni';
  @override
  VerificationContext validateIntegrity(Insertable<Assunzione> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('terapia_id')) {
      context.handle(_terapiaIdMeta,
          terapiaId.isAcceptableOrUnknown(data['terapia_id']!, _terapiaIdMeta));
    } else if (isInserting) {
      context.missing(_terapiaIdMeta);
    }
    if (data.containsKey('orario_id')) {
      context.handle(_orarioIdMeta,
          orarioId.isAcceptableOrUnknown(data['orario_id']!, _orarioIdMeta));
    }
    if (data.containsKey('data_ora_prevista')) {
      context.handle(
          _dataOraPrevistaMeta,
          dataOraPrevista.isAcceptableOrUnknown(
              data['data_ora_prevista']!, _dataOraPrevistaMeta));
    } else if (isInserting) {
      context.missing(_dataOraPrevistaMeta);
    }
    if (data.containsKey('data_ora_registrazione')) {
      context.handle(
          _dataOraRegistrazioneMeta,
          dataOraRegistrazione.isAcceptableOrUnknown(
              data['data_ora_registrazione']!, _dataOraRegistrazioneMeta));
    }
    if (data.containsKey('note')) {
      context.handle(
          _noteMeta, note.isAcceptableOrUnknown(data['note']!, _noteMeta));
    }
    if (data.containsKey('sincronizzato')) {
      context.handle(
          _sincronizzatoMeta,
          sincronizzato.isAcceptableOrUnknown(
              data['sincronizzato']!, _sincronizzatoMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Assunzione map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Assunzione(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      terapiaId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}terapia_id'])!,
      orarioId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}orario_id']),
      dataOraPrevista: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}data_ora_prevista'])!,
      dataOraRegistrazione: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime,
          data['${effectivePrefix}data_ora_registrazione']),
      stato: $AssunzioniTable.$converterstato.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}stato'])!),
      note: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}note']),
      sincronizzato: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}sincronizzato'])!,
    );
  }

  @override
  $AssunzioniTable createAlias(String alias) {
    return $AssunzioniTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<StatoAssunzione, int, int> $converterstato =
      const EnumIndexConverter<StatoAssunzione>(StatoAssunzione.values);
}

class Assunzione extends DataClass implements Insertable<Assunzione> {
  final int id;
  final int terapiaId;
  final int? orarioId;
  final DateTime dataOraPrevista;
  final DateTime? dataOraRegistrazione;
  final StatoAssunzione stato;
  final String? note;
  final bool sincronizzato;
  const Assunzione(
      {required this.id,
      required this.terapiaId,
      this.orarioId,
      required this.dataOraPrevista,
      this.dataOraRegistrazione,
      required this.stato,
      this.note,
      required this.sincronizzato});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['terapia_id'] = Variable<int>(terapiaId);
    if (!nullToAbsent || orarioId != null) {
      map['orario_id'] = Variable<int>(orarioId);
    }
    map['data_ora_prevista'] = Variable<DateTime>(dataOraPrevista);
    if (!nullToAbsent || dataOraRegistrazione != null) {
      map['data_ora_registrazione'] = Variable<DateTime>(dataOraRegistrazione);
    }
    {
      map['stato'] =
          Variable<int>($AssunzioniTable.$converterstato.toSql(stato));
    }
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    map['sincronizzato'] = Variable<bool>(sincronizzato);
    return map;
  }

  AssunzioniCompanion toCompanion(bool nullToAbsent) {
    return AssunzioniCompanion(
      id: Value(id),
      terapiaId: Value(terapiaId),
      orarioId: orarioId == null && nullToAbsent
          ? const Value.absent()
          : Value(orarioId),
      dataOraPrevista: Value(dataOraPrevista),
      dataOraRegistrazione: dataOraRegistrazione == null && nullToAbsent
          ? const Value.absent()
          : Value(dataOraRegistrazione),
      stato: Value(stato),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      sincronizzato: Value(sincronizzato),
    );
  }

  factory Assunzione.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Assunzione(
      id: serializer.fromJson<int>(json['id']),
      terapiaId: serializer.fromJson<int>(json['terapiaId']),
      orarioId: serializer.fromJson<int?>(json['orarioId']),
      dataOraPrevista: serializer.fromJson<DateTime>(json['dataOraPrevista']),
      dataOraRegistrazione:
          serializer.fromJson<DateTime?>(json['dataOraRegistrazione']),
      stato: $AssunzioniTable.$converterstato
          .fromJson(serializer.fromJson<int>(json['stato'])),
      note: serializer.fromJson<String?>(json['note']),
      sincronizzato: serializer.fromJson<bool>(json['sincronizzato']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'terapiaId': serializer.toJson<int>(terapiaId),
      'orarioId': serializer.toJson<int?>(orarioId),
      'dataOraPrevista': serializer.toJson<DateTime>(dataOraPrevista),
      'dataOraRegistrazione':
          serializer.toJson<DateTime?>(dataOraRegistrazione),
      'stato': serializer
          .toJson<int>($AssunzioniTable.$converterstato.toJson(stato)),
      'note': serializer.toJson<String?>(note),
      'sincronizzato': serializer.toJson<bool>(sincronizzato),
    };
  }

  Assunzione copyWith(
          {int? id,
          int? terapiaId,
          Value<int?> orarioId = const Value.absent(),
          DateTime? dataOraPrevista,
          Value<DateTime?> dataOraRegistrazione = const Value.absent(),
          StatoAssunzione? stato,
          Value<String?> note = const Value.absent(),
          bool? sincronizzato}) =>
      Assunzione(
        id: id ?? this.id,
        terapiaId: terapiaId ?? this.terapiaId,
        orarioId: orarioId.present ? orarioId.value : this.orarioId,
        dataOraPrevista: dataOraPrevista ?? this.dataOraPrevista,
        dataOraRegistrazione: dataOraRegistrazione.present
            ? dataOraRegistrazione.value
            : this.dataOraRegistrazione,
        stato: stato ?? this.stato,
        note: note.present ? note.value : this.note,
        sincronizzato: sincronizzato ?? this.sincronizzato,
      );
  Assunzione copyWithCompanion(AssunzioniCompanion data) {
    return Assunzione(
      id: data.id.present ? data.id.value : this.id,
      terapiaId: data.terapiaId.present ? data.terapiaId.value : this.terapiaId,
      orarioId: data.orarioId.present ? data.orarioId.value : this.orarioId,
      dataOraPrevista: data.dataOraPrevista.present
          ? data.dataOraPrevista.value
          : this.dataOraPrevista,
      dataOraRegistrazione: data.dataOraRegistrazione.present
          ? data.dataOraRegistrazione.value
          : this.dataOraRegistrazione,
      stato: data.stato.present ? data.stato.value : this.stato,
      note: data.note.present ? data.note.value : this.note,
      sincronizzato: data.sincronizzato.present
          ? data.sincronizzato.value
          : this.sincronizzato,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Assunzione(')
          ..write('id: $id, ')
          ..write('terapiaId: $terapiaId, ')
          ..write('orarioId: $orarioId, ')
          ..write('dataOraPrevista: $dataOraPrevista, ')
          ..write('dataOraRegistrazione: $dataOraRegistrazione, ')
          ..write('stato: $stato, ')
          ..write('note: $note, ')
          ..write('sincronizzato: $sincronizzato')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, terapiaId, orarioId, dataOraPrevista,
      dataOraRegistrazione, stato, note, sincronizzato);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Assunzione &&
          other.id == this.id &&
          other.terapiaId == this.terapiaId &&
          other.orarioId == this.orarioId &&
          other.dataOraPrevista == this.dataOraPrevista &&
          other.dataOraRegistrazione == this.dataOraRegistrazione &&
          other.stato == this.stato &&
          other.note == this.note &&
          other.sincronizzato == this.sincronizzato);
}

class AssunzioniCompanion extends UpdateCompanion<Assunzione> {
  final Value<int> id;
  final Value<int> terapiaId;
  final Value<int?> orarioId;
  final Value<DateTime> dataOraPrevista;
  final Value<DateTime?> dataOraRegistrazione;
  final Value<StatoAssunzione> stato;
  final Value<String?> note;
  final Value<bool> sincronizzato;
  const AssunzioniCompanion({
    this.id = const Value.absent(),
    this.terapiaId = const Value.absent(),
    this.orarioId = const Value.absent(),
    this.dataOraPrevista = const Value.absent(),
    this.dataOraRegistrazione = const Value.absent(),
    this.stato = const Value.absent(),
    this.note = const Value.absent(),
    this.sincronizzato = const Value.absent(),
  });
  AssunzioniCompanion.insert({
    this.id = const Value.absent(),
    required int terapiaId,
    this.orarioId = const Value.absent(),
    required DateTime dataOraPrevista,
    this.dataOraRegistrazione = const Value.absent(),
    required StatoAssunzione stato,
    this.note = const Value.absent(),
    this.sincronizzato = const Value.absent(),
  })  : terapiaId = Value(terapiaId),
        dataOraPrevista = Value(dataOraPrevista),
        stato = Value(stato);
  static Insertable<Assunzione> custom({
    Expression<int>? id,
    Expression<int>? terapiaId,
    Expression<int>? orarioId,
    Expression<DateTime>? dataOraPrevista,
    Expression<DateTime>? dataOraRegistrazione,
    Expression<int>? stato,
    Expression<String>? note,
    Expression<bool>? sincronizzato,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (terapiaId != null) 'terapia_id': terapiaId,
      if (orarioId != null) 'orario_id': orarioId,
      if (dataOraPrevista != null) 'data_ora_prevista': dataOraPrevista,
      if (dataOraRegistrazione != null)
        'data_ora_registrazione': dataOraRegistrazione,
      if (stato != null) 'stato': stato,
      if (note != null) 'note': note,
      if (sincronizzato != null) 'sincronizzato': sincronizzato,
    });
  }

  AssunzioniCompanion copyWith(
      {Value<int>? id,
      Value<int>? terapiaId,
      Value<int?>? orarioId,
      Value<DateTime>? dataOraPrevista,
      Value<DateTime?>? dataOraRegistrazione,
      Value<StatoAssunzione>? stato,
      Value<String?>? note,
      Value<bool>? sincronizzato}) {
    return AssunzioniCompanion(
      id: id ?? this.id,
      terapiaId: terapiaId ?? this.terapiaId,
      orarioId: orarioId ?? this.orarioId,
      dataOraPrevista: dataOraPrevista ?? this.dataOraPrevista,
      dataOraRegistrazione: dataOraRegistrazione ?? this.dataOraRegistrazione,
      stato: stato ?? this.stato,
      note: note ?? this.note,
      sincronizzato: sincronizzato ?? this.sincronizzato,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (terapiaId.present) {
      map['terapia_id'] = Variable<int>(terapiaId.value);
    }
    if (orarioId.present) {
      map['orario_id'] = Variable<int>(orarioId.value);
    }
    if (dataOraPrevista.present) {
      map['data_ora_prevista'] = Variable<DateTime>(dataOraPrevista.value);
    }
    if (dataOraRegistrazione.present) {
      map['data_ora_registrazione'] =
          Variable<DateTime>(dataOraRegistrazione.value);
    }
    if (stato.present) {
      map['stato'] =
          Variable<int>($AssunzioniTable.$converterstato.toSql(stato.value));
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (sincronizzato.present) {
      map['sincronizzato'] = Variable<bool>(sincronizzato.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AssunzioniCompanion(')
          ..write('id: $id, ')
          ..write('terapiaId: $terapiaId, ')
          ..write('orarioId: $orarioId, ')
          ..write('dataOraPrevista: $dataOraPrevista, ')
          ..write('dataOraRegistrazione: $dataOraRegistrazione, ')
          ..write('stato: $stato, ')
          ..write('note: $note, ')
          ..write('sincronizzato: $sincronizzato')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $PazientiTable pazienti = $PazientiTable(this);
  late final $PatologieTable patologie = $PatologieTable(this);
  late final $RisposteAnamnesiTable risposteAnamnesi =
      $RisposteAnamnesiTable(this);
  late final $CatalogoParametriTable catalogoParametri =
      $CatalogoParametriTable(this);
  late final $ParametriAbilitatiTable parametriAbilitati =
      $ParametriAbilitatiTable(this);
  late final $MisurazioniTable misurazioni = $MisurazioniTable(this);
  late final $TemplateRefertiTable templateReferti =
      $TemplateRefertiTable(this);
  late final $TerapieTable terapie = $TerapieTable(this);
  late final $OrariTerapiaTable orariTerapia = $OrariTerapiaTable(this);
  late final $AssunzioniTable assunzioni = $AssunzioniTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        pazienti,
        patologie,
        risposteAnamnesi,
        catalogoParametri,
        parametriAbilitati,
        misurazioni,
        templateReferti,
        terapie,
        orariTerapia,
        assunzioni
      ];
}

typedef $$PazientiTableCreateCompanionBuilder = PazientiCompanion Function({
  Value<int> id,
  required String cognome,
  required String nome,
  required String codiceFiscale,
  required DateTime dataNascita,
  Value<String?> indirizzo,
  Value<String?> telefono,
  required String cellulare,
  Value<String?> email,
});
typedef $$PazientiTableUpdateCompanionBuilder = PazientiCompanion Function({
  Value<int> id,
  Value<String> cognome,
  Value<String> nome,
  Value<String> codiceFiscale,
  Value<DateTime> dataNascita,
  Value<String?> indirizzo,
  Value<String?> telefono,
  Value<String> cellulare,
  Value<String?> email,
});

final class $$PazientiTableReferences
    extends BaseReferences<_$AppDatabase, $PazientiTable, Paziente> {
  $$PazientiTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$PatologieTable, List<Patologia>>
      _patologieRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
          db.patologie,
          aliasName:
              $_aliasNameGenerator(db.pazienti.id, db.patologie.pazienteId));

  $$PatologieTableProcessedTableManager get patologieRefs {
    final manager = $$PatologieTableTableManager($_db, $_db.patologie)
        .filter((f) => f.pazienteId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_patologieRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$RisposteAnamnesiTable, List<RispostaAnamnesi>>
      _risposteAnamnesiRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.risposteAnamnesi,
              aliasName: $_aliasNameGenerator(
                  db.pazienti.id, db.risposteAnamnesi.pazienteId));

  $$RisposteAnamnesiTableProcessedTableManager get risposteAnamnesiRefs {
    final manager =
        $$RisposteAnamnesiTableTableManager($_db, $_db.risposteAnamnesi)
            .filter((f) => f.pazienteId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_risposteAnamnesiRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$ParametriAbilitatiTable, List<ParametroAbilitato>>
      _parametriAbilitatiRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.parametriAbilitati,
              aliasName: $_aliasNameGenerator(
                  db.pazienti.id, db.parametriAbilitati.pazienteId));

  $$ParametriAbilitatiTableProcessedTableManager get parametriAbilitatiRefs {
    final manager =
        $$ParametriAbilitatiTableTableManager($_db, $_db.parametriAbilitati)
            .filter((f) => f.pazienteId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_parametriAbilitatiRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$MisurazioniTable, List<Misurazione>>
      _misurazioniRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
          db.misurazioni,
          aliasName:
              $_aliasNameGenerator(db.pazienti.id, db.misurazioni.pazienteId));

  $$MisurazioniTableProcessedTableManager get misurazioniRefs {
    final manager = $$MisurazioniTableTableManager($_db, $_db.misurazioni)
        .filter((f) => f.pazienteId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_misurazioniRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$TerapieTable, List<Terapia>> _terapieRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.terapie,
          aliasName:
              $_aliasNameGenerator(db.pazienti.id, db.terapie.pazienteId));

  $$TerapieTableProcessedTableManager get terapieRefs {
    final manager = $$TerapieTableTableManager($_db, $_db.terapie)
        .filter((f) => f.pazienteId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_terapieRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$PazientiTableFilterComposer
    extends Composer<_$AppDatabase, $PazientiTable> {
  $$PazientiTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get cognome => $composableBuilder(
      column: $table.cognome, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get nome => $composableBuilder(
      column: $table.nome, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get codiceFiscale => $composableBuilder(
      column: $table.codiceFiscale, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get dataNascita => $composableBuilder(
      column: $table.dataNascita, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get indirizzo => $composableBuilder(
      column: $table.indirizzo, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get telefono => $composableBuilder(
      column: $table.telefono, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get cellulare => $composableBuilder(
      column: $table.cellulare, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get email => $composableBuilder(
      column: $table.email, builder: (column) => ColumnFilters(column));

  Expression<bool> patologieRefs(
      Expression<bool> Function($$PatologieTableFilterComposer f) f) {
    final $$PatologieTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.patologie,
        getReferencedColumn: (t) => t.pazienteId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PatologieTableFilterComposer(
              $db: $db,
              $table: $db.patologie,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> risposteAnamnesiRefs(
      Expression<bool> Function($$RisposteAnamnesiTableFilterComposer f) f) {
    final $$RisposteAnamnesiTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.risposteAnamnesi,
        getReferencedColumn: (t) => t.pazienteId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$RisposteAnamnesiTableFilterComposer(
              $db: $db,
              $table: $db.risposteAnamnesi,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> parametriAbilitatiRefs(
      Expression<bool> Function($$ParametriAbilitatiTableFilterComposer f) f) {
    final $$ParametriAbilitatiTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.parametriAbilitati,
        getReferencedColumn: (t) => t.pazienteId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ParametriAbilitatiTableFilterComposer(
              $db: $db,
              $table: $db.parametriAbilitati,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> misurazioniRefs(
      Expression<bool> Function($$MisurazioniTableFilterComposer f) f) {
    final $$MisurazioniTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.misurazioni,
        getReferencedColumn: (t) => t.pazienteId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MisurazioniTableFilterComposer(
              $db: $db,
              $table: $db.misurazioni,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> terapieRefs(
      Expression<bool> Function($$TerapieTableFilterComposer f) f) {
    final $$TerapieTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.terapie,
        getReferencedColumn: (t) => t.pazienteId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TerapieTableFilterComposer(
              $db: $db,
              $table: $db.terapie,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$PazientiTableOrderingComposer
    extends Composer<_$AppDatabase, $PazientiTable> {
  $$PazientiTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get cognome => $composableBuilder(
      column: $table.cognome, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get nome => $composableBuilder(
      column: $table.nome, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get codiceFiscale => $composableBuilder(
      column: $table.codiceFiscale,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get dataNascita => $composableBuilder(
      column: $table.dataNascita, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get indirizzo => $composableBuilder(
      column: $table.indirizzo, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get telefono => $composableBuilder(
      column: $table.telefono, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get cellulare => $composableBuilder(
      column: $table.cellulare, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get email => $composableBuilder(
      column: $table.email, builder: (column) => ColumnOrderings(column));
}

class $$PazientiTableAnnotationComposer
    extends Composer<_$AppDatabase, $PazientiTable> {
  $$PazientiTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get cognome =>
      $composableBuilder(column: $table.cognome, builder: (column) => column);

  GeneratedColumn<String> get nome =>
      $composableBuilder(column: $table.nome, builder: (column) => column);

  GeneratedColumn<String> get codiceFiscale => $composableBuilder(
      column: $table.codiceFiscale, builder: (column) => column);

  GeneratedColumn<DateTime> get dataNascita => $composableBuilder(
      column: $table.dataNascita, builder: (column) => column);

  GeneratedColumn<String> get indirizzo =>
      $composableBuilder(column: $table.indirizzo, builder: (column) => column);

  GeneratedColumn<String> get telefono =>
      $composableBuilder(column: $table.telefono, builder: (column) => column);

  GeneratedColumn<String> get cellulare =>
      $composableBuilder(column: $table.cellulare, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  Expression<T> patologieRefs<T extends Object>(
      Expression<T> Function($$PatologieTableAnnotationComposer a) f) {
    final $$PatologieTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.patologie,
        getReferencedColumn: (t) => t.pazienteId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PatologieTableAnnotationComposer(
              $db: $db,
              $table: $db.patologie,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> risposteAnamnesiRefs<T extends Object>(
      Expression<T> Function($$RisposteAnamnesiTableAnnotationComposer a) f) {
    final $$RisposteAnamnesiTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.risposteAnamnesi,
        getReferencedColumn: (t) => t.pazienteId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$RisposteAnamnesiTableAnnotationComposer(
              $db: $db,
              $table: $db.risposteAnamnesi,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> parametriAbilitatiRefs<T extends Object>(
      Expression<T> Function($$ParametriAbilitatiTableAnnotationComposer a) f) {
    final $$ParametriAbilitatiTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.parametriAbilitati,
            getReferencedColumn: (t) => t.pazienteId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$ParametriAbilitatiTableAnnotationComposer(
                  $db: $db,
                  $table: $db.parametriAbilitati,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }

  Expression<T> misurazioniRefs<T extends Object>(
      Expression<T> Function($$MisurazioniTableAnnotationComposer a) f) {
    final $$MisurazioniTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.misurazioni,
        getReferencedColumn: (t) => t.pazienteId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MisurazioniTableAnnotationComposer(
              $db: $db,
              $table: $db.misurazioni,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> terapieRefs<T extends Object>(
      Expression<T> Function($$TerapieTableAnnotationComposer a) f) {
    final $$TerapieTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.terapie,
        getReferencedColumn: (t) => t.pazienteId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TerapieTableAnnotationComposer(
              $db: $db,
              $table: $db.terapie,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$PazientiTableTableManager extends RootTableManager<
    _$AppDatabase,
    $PazientiTable,
    Paziente,
    $$PazientiTableFilterComposer,
    $$PazientiTableOrderingComposer,
    $$PazientiTableAnnotationComposer,
    $$PazientiTableCreateCompanionBuilder,
    $$PazientiTableUpdateCompanionBuilder,
    (Paziente, $$PazientiTableReferences),
    Paziente,
    PrefetchHooks Function(
        {bool patologieRefs,
        bool risposteAnamnesiRefs,
        bool parametriAbilitatiRefs,
        bool misurazioniRefs,
        bool terapieRefs})> {
  $$PazientiTableTableManager(_$AppDatabase db, $PazientiTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PazientiTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PazientiTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PazientiTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> cognome = const Value.absent(),
            Value<String> nome = const Value.absent(),
            Value<String> codiceFiscale = const Value.absent(),
            Value<DateTime> dataNascita = const Value.absent(),
            Value<String?> indirizzo = const Value.absent(),
            Value<String?> telefono = const Value.absent(),
            Value<String> cellulare = const Value.absent(),
            Value<String?> email = const Value.absent(),
          }) =>
              PazientiCompanion(
            id: id,
            cognome: cognome,
            nome: nome,
            codiceFiscale: codiceFiscale,
            dataNascita: dataNascita,
            indirizzo: indirizzo,
            telefono: telefono,
            cellulare: cellulare,
            email: email,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String cognome,
            required String nome,
            required String codiceFiscale,
            required DateTime dataNascita,
            Value<String?> indirizzo = const Value.absent(),
            Value<String?> telefono = const Value.absent(),
            required String cellulare,
            Value<String?> email = const Value.absent(),
          }) =>
              PazientiCompanion.insert(
            id: id,
            cognome: cognome,
            nome: nome,
            codiceFiscale: codiceFiscale,
            dataNascita: dataNascita,
            indirizzo: indirizzo,
            telefono: telefono,
            cellulare: cellulare,
            email: email,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$PazientiTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: (
              {patologieRefs = false,
              risposteAnamnesiRefs = false,
              parametriAbilitatiRefs = false,
              misurazioniRefs = false,
              terapieRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (patologieRefs) db.patologie,
                if (risposteAnamnesiRefs) db.risposteAnamnesi,
                if (parametriAbilitatiRefs) db.parametriAbilitati,
                if (misurazioniRefs) db.misurazioni,
                if (terapieRefs) db.terapie
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (patologieRefs)
                    await $_getPrefetchedData<Paziente, $PazientiTable,
                            Patologia>(
                        currentTable: table,
                        referencedTable:
                            $$PazientiTableReferences._patologieRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$PazientiTableReferences(db, table, p0)
                                .patologieRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.pazienteId == item.id),
                        typedResults: items),
                  if (risposteAnamnesiRefs)
                    await $_getPrefetchedData<Paziente, $PazientiTable,
                            RispostaAnamnesi>(
                        currentTable: table,
                        referencedTable: $$PazientiTableReferences
                            ._risposteAnamnesiRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$PazientiTableReferences(db, table, p0)
                                .risposteAnamnesiRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.pazienteId == item.id),
                        typedResults: items),
                  if (parametriAbilitatiRefs)
                    await $_getPrefetchedData<Paziente, $PazientiTable,
                            ParametroAbilitato>(
                        currentTable: table,
                        referencedTable: $$PazientiTableReferences
                            ._parametriAbilitatiRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$PazientiTableReferences(db, table, p0)
                                .parametriAbilitatiRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.pazienteId == item.id),
                        typedResults: items),
                  if (misurazioniRefs)
                    await $_getPrefetchedData<Paziente, $PazientiTable,
                            Misurazione>(
                        currentTable: table,
                        referencedTable:
                            $$PazientiTableReferences._misurazioniRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$PazientiTableReferences(db, table, p0)
                                .misurazioniRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.pazienteId == item.id),
                        typedResults: items),
                  if (terapieRefs)
                    await $_getPrefetchedData<Paziente, $PazientiTable,
                            Terapia>(
                        currentTable: table,
                        referencedTable:
                            $$PazientiTableReferences._terapieRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$PazientiTableReferences(db, table, p0)
                                .terapieRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.pazienteId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$PazientiTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $PazientiTable,
    Paziente,
    $$PazientiTableFilterComposer,
    $$PazientiTableOrderingComposer,
    $$PazientiTableAnnotationComposer,
    $$PazientiTableCreateCompanionBuilder,
    $$PazientiTableUpdateCompanionBuilder,
    (Paziente, $$PazientiTableReferences),
    Paziente,
    PrefetchHooks Function(
        {bool patologieRefs,
        bool risposteAnamnesiRefs,
        bool parametriAbilitatiRefs,
        bool misurazioniRefs,
        bool terapieRefs})>;
typedef $$PatologieTableCreateCompanionBuilder = PatologieCompanion Function({
  Value<int> id,
  required int pazienteId,
  required String nome,
});
typedef $$PatologieTableUpdateCompanionBuilder = PatologieCompanion Function({
  Value<int> id,
  Value<int> pazienteId,
  Value<String> nome,
});

final class $$PatologieTableReferences
    extends BaseReferences<_$AppDatabase, $PatologieTable, Patologia> {
  $$PatologieTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $PazientiTable _pazienteIdTable(_$AppDatabase db) =>
      db.pazienti.createAlias(
          $_aliasNameGenerator(db.patologie.pazienteId, db.pazienti.id));

  $$PazientiTableProcessedTableManager get pazienteId {
    final $_column = $_itemColumn<int>('paziente_id')!;

    final manager = $$PazientiTableTableManager($_db, $_db.pazienti)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_pazienteIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$TerapieTable, List<Terapia>> _terapieRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.terapie,
          aliasName:
              $_aliasNameGenerator(db.patologie.id, db.terapie.patologiaId));

  $$TerapieTableProcessedTableManager get terapieRefs {
    final manager = $$TerapieTableTableManager($_db, $_db.terapie)
        .filter((f) => f.patologiaId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_terapieRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$PatologieTableFilterComposer
    extends Composer<_$AppDatabase, $PatologieTable> {
  $$PatologieTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get nome => $composableBuilder(
      column: $table.nome, builder: (column) => ColumnFilters(column));

  $$PazientiTableFilterComposer get pazienteId {
    final $$PazientiTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.pazienteId,
        referencedTable: $db.pazienti,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PazientiTableFilterComposer(
              $db: $db,
              $table: $db.pazienti,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> terapieRefs(
      Expression<bool> Function($$TerapieTableFilterComposer f) f) {
    final $$TerapieTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.terapie,
        getReferencedColumn: (t) => t.patologiaId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TerapieTableFilterComposer(
              $db: $db,
              $table: $db.terapie,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$PatologieTableOrderingComposer
    extends Composer<_$AppDatabase, $PatologieTable> {
  $$PatologieTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get nome => $composableBuilder(
      column: $table.nome, builder: (column) => ColumnOrderings(column));

  $$PazientiTableOrderingComposer get pazienteId {
    final $$PazientiTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.pazienteId,
        referencedTable: $db.pazienti,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PazientiTableOrderingComposer(
              $db: $db,
              $table: $db.pazienti,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$PatologieTableAnnotationComposer
    extends Composer<_$AppDatabase, $PatologieTable> {
  $$PatologieTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nome =>
      $composableBuilder(column: $table.nome, builder: (column) => column);

  $$PazientiTableAnnotationComposer get pazienteId {
    final $$PazientiTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.pazienteId,
        referencedTable: $db.pazienti,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PazientiTableAnnotationComposer(
              $db: $db,
              $table: $db.pazienti,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> terapieRefs<T extends Object>(
      Expression<T> Function($$TerapieTableAnnotationComposer a) f) {
    final $$TerapieTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.terapie,
        getReferencedColumn: (t) => t.patologiaId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TerapieTableAnnotationComposer(
              $db: $db,
              $table: $db.terapie,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$PatologieTableTableManager extends RootTableManager<
    _$AppDatabase,
    $PatologieTable,
    Patologia,
    $$PatologieTableFilterComposer,
    $$PatologieTableOrderingComposer,
    $$PatologieTableAnnotationComposer,
    $$PatologieTableCreateCompanionBuilder,
    $$PatologieTableUpdateCompanionBuilder,
    (Patologia, $$PatologieTableReferences),
    Patologia,
    PrefetchHooks Function({bool pazienteId, bool terapieRefs})> {
  $$PatologieTableTableManager(_$AppDatabase db, $PatologieTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PatologieTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PatologieTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PatologieTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> pazienteId = const Value.absent(),
            Value<String> nome = const Value.absent(),
          }) =>
              PatologieCompanion(
            id: id,
            pazienteId: pazienteId,
            nome: nome,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int pazienteId,
            required String nome,
          }) =>
              PatologieCompanion.insert(
            id: id,
            pazienteId: pazienteId,
            nome: nome,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$PatologieTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({pazienteId = false, terapieRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (terapieRefs) db.terapie],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (pazienteId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.pazienteId,
                    referencedTable:
                        $$PatologieTableReferences._pazienteIdTable(db),
                    referencedColumn:
                        $$PatologieTableReferences._pazienteIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (terapieRefs)
                    await $_getPrefetchedData<Patologia, $PatologieTable,
                            Terapia>(
                        currentTable: table,
                        referencedTable:
                            $$PatologieTableReferences._terapieRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$PatologieTableReferences(db, table, p0)
                                .terapieRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.patologiaId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$PatologieTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $PatologieTable,
    Patologia,
    $$PatologieTableFilterComposer,
    $$PatologieTableOrderingComposer,
    $$PatologieTableAnnotationComposer,
    $$PatologieTableCreateCompanionBuilder,
    $$PatologieTableUpdateCompanionBuilder,
    (Patologia, $$PatologieTableReferences),
    Patologia,
    PrefetchHooks Function({bool pazienteId, bool terapieRefs})>;
typedef $$RisposteAnamnesiTableCreateCompanionBuilder
    = RisposteAnamnesiCompanion Function({
  Value<int> id,
  required int pazienteId,
  required String domanda,
  required bool risposta,
});
typedef $$RisposteAnamnesiTableUpdateCompanionBuilder
    = RisposteAnamnesiCompanion Function({
  Value<int> id,
  Value<int> pazienteId,
  Value<String> domanda,
  Value<bool> risposta,
});

final class $$RisposteAnamnesiTableReferences extends BaseReferences<
    _$AppDatabase, $RisposteAnamnesiTable, RispostaAnamnesi> {
  $$RisposteAnamnesiTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $PazientiTable _pazienteIdTable(_$AppDatabase db) =>
      db.pazienti.createAlias(
          $_aliasNameGenerator(db.risposteAnamnesi.pazienteId, db.pazienti.id));

  $$PazientiTableProcessedTableManager get pazienteId {
    final $_column = $_itemColumn<int>('paziente_id')!;

    final manager = $$PazientiTableTableManager($_db, $_db.pazienti)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_pazienteIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$RisposteAnamnesiTableFilterComposer
    extends Composer<_$AppDatabase, $RisposteAnamnesiTable> {
  $$RisposteAnamnesiTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get domanda => $composableBuilder(
      column: $table.domanda, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get risposta => $composableBuilder(
      column: $table.risposta, builder: (column) => ColumnFilters(column));

  $$PazientiTableFilterComposer get pazienteId {
    final $$PazientiTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.pazienteId,
        referencedTable: $db.pazienti,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PazientiTableFilterComposer(
              $db: $db,
              $table: $db.pazienti,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$RisposteAnamnesiTableOrderingComposer
    extends Composer<_$AppDatabase, $RisposteAnamnesiTable> {
  $$RisposteAnamnesiTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get domanda => $composableBuilder(
      column: $table.domanda, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get risposta => $composableBuilder(
      column: $table.risposta, builder: (column) => ColumnOrderings(column));

  $$PazientiTableOrderingComposer get pazienteId {
    final $$PazientiTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.pazienteId,
        referencedTable: $db.pazienti,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PazientiTableOrderingComposer(
              $db: $db,
              $table: $db.pazienti,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$RisposteAnamnesiTableAnnotationComposer
    extends Composer<_$AppDatabase, $RisposteAnamnesiTable> {
  $$RisposteAnamnesiTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get domanda =>
      $composableBuilder(column: $table.domanda, builder: (column) => column);

  GeneratedColumn<bool> get risposta =>
      $composableBuilder(column: $table.risposta, builder: (column) => column);

  $$PazientiTableAnnotationComposer get pazienteId {
    final $$PazientiTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.pazienteId,
        referencedTable: $db.pazienti,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PazientiTableAnnotationComposer(
              $db: $db,
              $table: $db.pazienti,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$RisposteAnamnesiTableTableManager extends RootTableManager<
    _$AppDatabase,
    $RisposteAnamnesiTable,
    RispostaAnamnesi,
    $$RisposteAnamnesiTableFilterComposer,
    $$RisposteAnamnesiTableOrderingComposer,
    $$RisposteAnamnesiTableAnnotationComposer,
    $$RisposteAnamnesiTableCreateCompanionBuilder,
    $$RisposteAnamnesiTableUpdateCompanionBuilder,
    (RispostaAnamnesi, $$RisposteAnamnesiTableReferences),
    RispostaAnamnesi,
    PrefetchHooks Function({bool pazienteId})> {
  $$RisposteAnamnesiTableTableManager(
      _$AppDatabase db, $RisposteAnamnesiTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RisposteAnamnesiTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RisposteAnamnesiTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RisposteAnamnesiTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> pazienteId = const Value.absent(),
            Value<String> domanda = const Value.absent(),
            Value<bool> risposta = const Value.absent(),
          }) =>
              RisposteAnamnesiCompanion(
            id: id,
            pazienteId: pazienteId,
            domanda: domanda,
            risposta: risposta,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int pazienteId,
            required String domanda,
            required bool risposta,
          }) =>
              RisposteAnamnesiCompanion.insert(
            id: id,
            pazienteId: pazienteId,
            domanda: domanda,
            risposta: risposta,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$RisposteAnamnesiTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({pazienteId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (pazienteId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.pazienteId,
                    referencedTable:
                        $$RisposteAnamnesiTableReferences._pazienteIdTable(db),
                    referencedColumn: $$RisposteAnamnesiTableReferences
                        ._pazienteIdTable(db)
                        .id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$RisposteAnamnesiTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $RisposteAnamnesiTable,
    RispostaAnamnesi,
    $$RisposteAnamnesiTableFilterComposer,
    $$RisposteAnamnesiTableOrderingComposer,
    $$RisposteAnamnesiTableAnnotationComposer,
    $$RisposteAnamnesiTableCreateCompanionBuilder,
    $$RisposteAnamnesiTableUpdateCompanionBuilder,
    (RispostaAnamnesi, $$RisposteAnamnesiTableReferences),
    RispostaAnamnesi,
    PrefetchHooks Function({bool pazienteId})>;
typedef $$CatalogoParametriTableCreateCompanionBuilder
    = CatalogoParametriCompanion Function({
  Value<int> id,
  required String nomeVisualizzato,
  required String codice,
  required String unitaMisura,
  required TipoValore tipoValore,
  required String etichettaValore1,
  Value<String?> etichettaValore2,
  Value<double?> sogliaNormaleMin,
  Value<double?> sogliaNormaleMax,
  Value<double?> sogliaAttenzioneMax,
  Value<double?> sogliaAllarmeMax,
  required FonteParametro fonte,
  Value<int> ordineVisualizzazione,
  Value<bool> attivo,
});
typedef $$CatalogoParametriTableUpdateCompanionBuilder
    = CatalogoParametriCompanion Function({
  Value<int> id,
  Value<String> nomeVisualizzato,
  Value<String> codice,
  Value<String> unitaMisura,
  Value<TipoValore> tipoValore,
  Value<String> etichettaValore1,
  Value<String?> etichettaValore2,
  Value<double?> sogliaNormaleMin,
  Value<double?> sogliaNormaleMax,
  Value<double?> sogliaAttenzioneMax,
  Value<double?> sogliaAllarmeMax,
  Value<FonteParametro> fonte,
  Value<int> ordineVisualizzazione,
  Value<bool> attivo,
});

final class $$CatalogoParametriTableReferences extends BaseReferences<
    _$AppDatabase, $CatalogoParametriTable, ParametroCatalogo> {
  $$CatalogoParametriTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$ParametriAbilitatiTable, List<ParametroAbilitato>>
      _parametriAbilitatiRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.parametriAbilitati,
              aliasName: $_aliasNameGenerator(
                  db.catalogoParametri.id, db.parametriAbilitati.parametroId));

  $$ParametriAbilitatiTableProcessedTableManager get parametriAbilitatiRefs {
    final manager = $$ParametriAbilitatiTableTableManager(
            $_db, $_db.parametriAbilitati)
        .filter((f) => f.parametroId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_parametriAbilitatiRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$MisurazioniTable, List<Misurazione>>
      _misurazioniRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.misurazioni,
              aliasName: $_aliasNameGenerator(
                  db.catalogoParametri.id, db.misurazioni.parametroId));

  $$MisurazioniTableProcessedTableManager get misurazioniRefs {
    final manager = $$MisurazioniTableTableManager($_db, $_db.misurazioni)
        .filter((f) => f.parametroId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_misurazioniRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$TemplateRefertiTable, List<TemplateReferto>>
      _templateRefertiRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.templateReferti,
              aliasName: $_aliasNameGenerator(
                  db.catalogoParametri.id, db.templateReferti.parametroId));

  $$TemplateRefertiTableProcessedTableManager get templateRefertiRefs {
    final manager = $$TemplateRefertiTableTableManager(
            $_db, $_db.templateReferti)
        .filter((f) => f.parametroId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_templateRefertiRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$CatalogoParametriTableFilterComposer
    extends Composer<_$AppDatabase, $CatalogoParametriTable> {
  $$CatalogoParametriTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get nomeVisualizzato => $composableBuilder(
      column: $table.nomeVisualizzato,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get codice => $composableBuilder(
      column: $table.codice, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get unitaMisura => $composableBuilder(
      column: $table.unitaMisura, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<TipoValore, TipoValore, int> get tipoValore =>
      $composableBuilder(
          column: $table.tipoValore,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<String> get etichettaValore1 => $composableBuilder(
      column: $table.etichettaValore1,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get etichettaValore2 => $composableBuilder(
      column: $table.etichettaValore2,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get sogliaNormaleMin => $composableBuilder(
      column: $table.sogliaNormaleMin,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get sogliaNormaleMax => $composableBuilder(
      column: $table.sogliaNormaleMax,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get sogliaAttenzioneMax => $composableBuilder(
      column: $table.sogliaAttenzioneMax,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get sogliaAllarmeMax => $composableBuilder(
      column: $table.sogliaAllarmeMax,
      builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<FonteParametro, FonteParametro, int>
      get fonte => $composableBuilder(
          column: $table.fonte,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<int> get ordineVisualizzazione => $composableBuilder(
      column: $table.ordineVisualizzazione,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get attivo => $composableBuilder(
      column: $table.attivo, builder: (column) => ColumnFilters(column));

  Expression<bool> parametriAbilitatiRefs(
      Expression<bool> Function($$ParametriAbilitatiTableFilterComposer f) f) {
    final $$ParametriAbilitatiTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.parametriAbilitati,
        getReferencedColumn: (t) => t.parametroId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ParametriAbilitatiTableFilterComposer(
              $db: $db,
              $table: $db.parametriAbilitati,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> misurazioniRefs(
      Expression<bool> Function($$MisurazioniTableFilterComposer f) f) {
    final $$MisurazioniTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.misurazioni,
        getReferencedColumn: (t) => t.parametroId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MisurazioniTableFilterComposer(
              $db: $db,
              $table: $db.misurazioni,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> templateRefertiRefs(
      Expression<bool> Function($$TemplateRefertiTableFilterComposer f) f) {
    final $$TemplateRefertiTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.templateReferti,
        getReferencedColumn: (t) => t.parametroId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TemplateRefertiTableFilterComposer(
              $db: $db,
              $table: $db.templateReferti,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$CatalogoParametriTableOrderingComposer
    extends Composer<_$AppDatabase, $CatalogoParametriTable> {
  $$CatalogoParametriTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get nomeVisualizzato => $composableBuilder(
      column: $table.nomeVisualizzato,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get codice => $composableBuilder(
      column: $table.codice, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get unitaMisura => $composableBuilder(
      column: $table.unitaMisura, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get tipoValore => $composableBuilder(
      column: $table.tipoValore, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get etichettaValore1 => $composableBuilder(
      column: $table.etichettaValore1,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get etichettaValore2 => $composableBuilder(
      column: $table.etichettaValore2,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get sogliaNormaleMin => $composableBuilder(
      column: $table.sogliaNormaleMin,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get sogliaNormaleMax => $composableBuilder(
      column: $table.sogliaNormaleMax,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get sogliaAttenzioneMax => $composableBuilder(
      column: $table.sogliaAttenzioneMax,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get sogliaAllarmeMax => $composableBuilder(
      column: $table.sogliaAllarmeMax,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get fonte => $composableBuilder(
      column: $table.fonte, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get ordineVisualizzazione => $composableBuilder(
      column: $table.ordineVisualizzazione,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get attivo => $composableBuilder(
      column: $table.attivo, builder: (column) => ColumnOrderings(column));
}

class $$CatalogoParametriTableAnnotationComposer
    extends Composer<_$AppDatabase, $CatalogoParametriTable> {
  $$CatalogoParametriTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nomeVisualizzato => $composableBuilder(
      column: $table.nomeVisualizzato, builder: (column) => column);

  GeneratedColumn<String> get codice =>
      $composableBuilder(column: $table.codice, builder: (column) => column);

  GeneratedColumn<String> get unitaMisura => $composableBuilder(
      column: $table.unitaMisura, builder: (column) => column);

  GeneratedColumnWithTypeConverter<TipoValore, int> get tipoValore =>
      $composableBuilder(
          column: $table.tipoValore, builder: (column) => column);

  GeneratedColumn<String> get etichettaValore1 => $composableBuilder(
      column: $table.etichettaValore1, builder: (column) => column);

  GeneratedColumn<String> get etichettaValore2 => $composableBuilder(
      column: $table.etichettaValore2, builder: (column) => column);

  GeneratedColumn<double> get sogliaNormaleMin => $composableBuilder(
      column: $table.sogliaNormaleMin, builder: (column) => column);

  GeneratedColumn<double> get sogliaNormaleMax => $composableBuilder(
      column: $table.sogliaNormaleMax, builder: (column) => column);

  GeneratedColumn<double> get sogliaAttenzioneMax => $composableBuilder(
      column: $table.sogliaAttenzioneMax, builder: (column) => column);

  GeneratedColumn<double> get sogliaAllarmeMax => $composableBuilder(
      column: $table.sogliaAllarmeMax, builder: (column) => column);

  GeneratedColumnWithTypeConverter<FonteParametro, int> get fonte =>
      $composableBuilder(column: $table.fonte, builder: (column) => column);

  GeneratedColumn<int> get ordineVisualizzazione => $composableBuilder(
      column: $table.ordineVisualizzazione, builder: (column) => column);

  GeneratedColumn<bool> get attivo =>
      $composableBuilder(column: $table.attivo, builder: (column) => column);

  Expression<T> parametriAbilitatiRefs<T extends Object>(
      Expression<T> Function($$ParametriAbilitatiTableAnnotationComposer a) f) {
    final $$ParametriAbilitatiTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.parametriAbilitati,
            getReferencedColumn: (t) => t.parametroId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$ParametriAbilitatiTableAnnotationComposer(
                  $db: $db,
                  $table: $db.parametriAbilitati,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }

  Expression<T> misurazioniRefs<T extends Object>(
      Expression<T> Function($$MisurazioniTableAnnotationComposer a) f) {
    final $$MisurazioniTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.misurazioni,
        getReferencedColumn: (t) => t.parametroId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MisurazioniTableAnnotationComposer(
              $db: $db,
              $table: $db.misurazioni,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> templateRefertiRefs<T extends Object>(
      Expression<T> Function($$TemplateRefertiTableAnnotationComposer a) f) {
    final $$TemplateRefertiTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.templateReferti,
        getReferencedColumn: (t) => t.parametroId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TemplateRefertiTableAnnotationComposer(
              $db: $db,
              $table: $db.templateReferti,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$CatalogoParametriTableTableManager extends RootTableManager<
    _$AppDatabase,
    $CatalogoParametriTable,
    ParametroCatalogo,
    $$CatalogoParametriTableFilterComposer,
    $$CatalogoParametriTableOrderingComposer,
    $$CatalogoParametriTableAnnotationComposer,
    $$CatalogoParametriTableCreateCompanionBuilder,
    $$CatalogoParametriTableUpdateCompanionBuilder,
    (ParametroCatalogo, $$CatalogoParametriTableReferences),
    ParametroCatalogo,
    PrefetchHooks Function(
        {bool parametriAbilitatiRefs,
        bool misurazioniRefs,
        bool templateRefertiRefs})> {
  $$CatalogoParametriTableTableManager(
      _$AppDatabase db, $CatalogoParametriTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CatalogoParametriTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CatalogoParametriTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CatalogoParametriTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> nomeVisualizzato = const Value.absent(),
            Value<String> codice = const Value.absent(),
            Value<String> unitaMisura = const Value.absent(),
            Value<TipoValore> tipoValore = const Value.absent(),
            Value<String> etichettaValore1 = const Value.absent(),
            Value<String?> etichettaValore2 = const Value.absent(),
            Value<double?> sogliaNormaleMin = const Value.absent(),
            Value<double?> sogliaNormaleMax = const Value.absent(),
            Value<double?> sogliaAttenzioneMax = const Value.absent(),
            Value<double?> sogliaAllarmeMax = const Value.absent(),
            Value<FonteParametro> fonte = const Value.absent(),
            Value<int> ordineVisualizzazione = const Value.absent(),
            Value<bool> attivo = const Value.absent(),
          }) =>
              CatalogoParametriCompanion(
            id: id,
            nomeVisualizzato: nomeVisualizzato,
            codice: codice,
            unitaMisura: unitaMisura,
            tipoValore: tipoValore,
            etichettaValore1: etichettaValore1,
            etichettaValore2: etichettaValore2,
            sogliaNormaleMin: sogliaNormaleMin,
            sogliaNormaleMax: sogliaNormaleMax,
            sogliaAttenzioneMax: sogliaAttenzioneMax,
            sogliaAllarmeMax: sogliaAllarmeMax,
            fonte: fonte,
            ordineVisualizzazione: ordineVisualizzazione,
            attivo: attivo,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String nomeVisualizzato,
            required String codice,
            required String unitaMisura,
            required TipoValore tipoValore,
            required String etichettaValore1,
            Value<String?> etichettaValore2 = const Value.absent(),
            Value<double?> sogliaNormaleMin = const Value.absent(),
            Value<double?> sogliaNormaleMax = const Value.absent(),
            Value<double?> sogliaAttenzioneMax = const Value.absent(),
            Value<double?> sogliaAllarmeMax = const Value.absent(),
            required FonteParametro fonte,
            Value<int> ordineVisualizzazione = const Value.absent(),
            Value<bool> attivo = const Value.absent(),
          }) =>
              CatalogoParametriCompanion.insert(
            id: id,
            nomeVisualizzato: nomeVisualizzato,
            codice: codice,
            unitaMisura: unitaMisura,
            tipoValore: tipoValore,
            etichettaValore1: etichettaValore1,
            etichettaValore2: etichettaValore2,
            sogliaNormaleMin: sogliaNormaleMin,
            sogliaNormaleMax: sogliaNormaleMax,
            sogliaAttenzioneMax: sogliaAttenzioneMax,
            sogliaAllarmeMax: sogliaAllarmeMax,
            fonte: fonte,
            ordineVisualizzazione: ordineVisualizzazione,
            attivo: attivo,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$CatalogoParametriTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {parametriAbilitatiRefs = false,
              misurazioniRefs = false,
              templateRefertiRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (parametriAbilitatiRefs) db.parametriAbilitati,
                if (misurazioniRefs) db.misurazioni,
                if (templateRefertiRefs) db.templateReferti
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (parametriAbilitatiRefs)
                    await $_getPrefetchedData<ParametroCatalogo,
                            $CatalogoParametriTable, ParametroAbilitato>(
                        currentTable: table,
                        referencedTable: $$CatalogoParametriTableReferences
                            ._parametriAbilitatiRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$CatalogoParametriTableReferences(db, table, p0)
                                .parametriAbilitatiRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.parametroId == item.id),
                        typedResults: items),
                  if (misurazioniRefs)
                    await $_getPrefetchedData<ParametroCatalogo,
                            $CatalogoParametriTable, Misurazione>(
                        currentTable: table,
                        referencedTable: $$CatalogoParametriTableReferences
                            ._misurazioniRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$CatalogoParametriTableReferences(db, table, p0)
                                .misurazioniRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.parametroId == item.id),
                        typedResults: items),
                  if (templateRefertiRefs)
                    await $_getPrefetchedData<ParametroCatalogo,
                            $CatalogoParametriTable, TemplateReferto>(
                        currentTable: table,
                        referencedTable: $$CatalogoParametriTableReferences
                            ._templateRefertiRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$CatalogoParametriTableReferences(db, table, p0)
                                .templateRefertiRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.parametroId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$CatalogoParametriTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $CatalogoParametriTable,
    ParametroCatalogo,
    $$CatalogoParametriTableFilterComposer,
    $$CatalogoParametriTableOrderingComposer,
    $$CatalogoParametriTableAnnotationComposer,
    $$CatalogoParametriTableCreateCompanionBuilder,
    $$CatalogoParametriTableUpdateCompanionBuilder,
    (ParametroCatalogo, $$CatalogoParametriTableReferences),
    ParametroCatalogo,
    PrefetchHooks Function(
        {bool parametriAbilitatiRefs,
        bool misurazioniRefs,
        bool templateRefertiRefs})>;
typedef $$ParametriAbilitatiTableCreateCompanionBuilder
    = ParametriAbilitatiCompanion Function({
  required int pazienteId,
  required int parametroId,
  Value<int> rowid,
});
typedef $$ParametriAbilitatiTableUpdateCompanionBuilder
    = ParametriAbilitatiCompanion Function({
  Value<int> pazienteId,
  Value<int> parametroId,
  Value<int> rowid,
});

final class $$ParametriAbilitatiTableReferences extends BaseReferences<
    _$AppDatabase, $ParametriAbilitatiTable, ParametroAbilitato> {
  $$ParametriAbilitatiTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $PazientiTable _pazienteIdTable(_$AppDatabase db) =>
      db.pazienti.createAlias($_aliasNameGenerator(
          db.parametriAbilitati.pazienteId, db.pazienti.id));

  $$PazientiTableProcessedTableManager get pazienteId {
    final $_column = $_itemColumn<int>('paziente_id')!;

    final manager = $$PazientiTableTableManager($_db, $_db.pazienti)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_pazienteIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $CatalogoParametriTable _parametroIdTable(_$AppDatabase db) =>
      db.catalogoParametri.createAlias($_aliasNameGenerator(
          db.parametriAbilitati.parametroId, db.catalogoParametri.id));

  $$CatalogoParametriTableProcessedTableManager get parametroId {
    final $_column = $_itemColumn<int>('parametro_id')!;

    final manager =
        $$CatalogoParametriTableTableManager($_db, $_db.catalogoParametri)
            .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_parametroIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$ParametriAbilitatiTableFilterComposer
    extends Composer<_$AppDatabase, $ParametriAbilitatiTable> {
  $$ParametriAbilitatiTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$PazientiTableFilterComposer get pazienteId {
    final $$PazientiTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.pazienteId,
        referencedTable: $db.pazienti,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PazientiTableFilterComposer(
              $db: $db,
              $table: $db.pazienti,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$CatalogoParametriTableFilterComposer get parametroId {
    final $$CatalogoParametriTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.parametroId,
        referencedTable: $db.catalogoParametri,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CatalogoParametriTableFilterComposer(
              $db: $db,
              $table: $db.catalogoParametri,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ParametriAbilitatiTableOrderingComposer
    extends Composer<_$AppDatabase, $ParametriAbilitatiTable> {
  $$ParametriAbilitatiTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$PazientiTableOrderingComposer get pazienteId {
    final $$PazientiTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.pazienteId,
        referencedTable: $db.pazienti,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PazientiTableOrderingComposer(
              $db: $db,
              $table: $db.pazienti,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$CatalogoParametriTableOrderingComposer get parametroId {
    final $$CatalogoParametriTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.parametroId,
        referencedTable: $db.catalogoParametri,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CatalogoParametriTableOrderingComposer(
              $db: $db,
              $table: $db.catalogoParametri,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ParametriAbilitatiTableAnnotationComposer
    extends Composer<_$AppDatabase, $ParametriAbilitatiTable> {
  $$ParametriAbilitatiTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$PazientiTableAnnotationComposer get pazienteId {
    final $$PazientiTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.pazienteId,
        referencedTable: $db.pazienti,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PazientiTableAnnotationComposer(
              $db: $db,
              $table: $db.pazienti,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$CatalogoParametriTableAnnotationComposer get parametroId {
    final $$CatalogoParametriTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.parametroId,
            referencedTable: $db.catalogoParametri,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$CatalogoParametriTableAnnotationComposer(
                  $db: $db,
                  $table: $db.catalogoParametri,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return composer;
  }
}

class $$ParametriAbilitatiTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ParametriAbilitatiTable,
    ParametroAbilitato,
    $$ParametriAbilitatiTableFilterComposer,
    $$ParametriAbilitatiTableOrderingComposer,
    $$ParametriAbilitatiTableAnnotationComposer,
    $$ParametriAbilitatiTableCreateCompanionBuilder,
    $$ParametriAbilitatiTableUpdateCompanionBuilder,
    (ParametroAbilitato, $$ParametriAbilitatiTableReferences),
    ParametroAbilitato,
    PrefetchHooks Function({bool pazienteId, bool parametroId})> {
  $$ParametriAbilitatiTableTableManager(
      _$AppDatabase db, $ParametriAbilitatiTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ParametriAbilitatiTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ParametriAbilitatiTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ParametriAbilitatiTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> pazienteId = const Value.absent(),
            Value<int> parametroId = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ParametriAbilitatiCompanion(
            pazienteId: pazienteId,
            parametroId: parametroId,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required int pazienteId,
            required int parametroId,
            Value<int> rowid = const Value.absent(),
          }) =>
              ParametriAbilitatiCompanion.insert(
            pazienteId: pazienteId,
            parametroId: parametroId,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$ParametriAbilitatiTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({pazienteId = false, parametroId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (pazienteId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.pazienteId,
                    referencedTable: $$ParametriAbilitatiTableReferences
                        ._pazienteIdTable(db),
                    referencedColumn: $$ParametriAbilitatiTableReferences
                        ._pazienteIdTable(db)
                        .id,
                  ) as T;
                }
                if (parametroId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.parametroId,
                    referencedTable: $$ParametriAbilitatiTableReferences
                        ._parametroIdTable(db),
                    referencedColumn: $$ParametriAbilitatiTableReferences
                        ._parametroIdTable(db)
                        .id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$ParametriAbilitatiTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ParametriAbilitatiTable,
    ParametroAbilitato,
    $$ParametriAbilitatiTableFilterComposer,
    $$ParametriAbilitatiTableOrderingComposer,
    $$ParametriAbilitatiTableAnnotationComposer,
    $$ParametriAbilitatiTableCreateCompanionBuilder,
    $$ParametriAbilitatiTableUpdateCompanionBuilder,
    (ParametroAbilitato, $$ParametriAbilitatiTableReferences),
    ParametroAbilitato,
    PrefetchHooks Function({bool pazienteId, bool parametroId})>;
typedef $$MisurazioniTableCreateCompanionBuilder = MisurazioniCompanion
    Function({
  Value<int> id,
  required int pazienteId,
  required int parametroId,
  Value<double?> valore1,
  Value<double?> valore2,
  Value<String?> valoreTesto,
  required DateTime data,
  required FonteParametro fonteEffettiva,
  Value<bool> sincronizzato,
});
typedef $$MisurazioniTableUpdateCompanionBuilder = MisurazioniCompanion
    Function({
  Value<int> id,
  Value<int> pazienteId,
  Value<int> parametroId,
  Value<double?> valore1,
  Value<double?> valore2,
  Value<String?> valoreTesto,
  Value<DateTime> data,
  Value<FonteParametro> fonteEffettiva,
  Value<bool> sincronizzato,
});

final class $$MisurazioniTableReferences
    extends BaseReferences<_$AppDatabase, $MisurazioniTable, Misurazione> {
  $$MisurazioniTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $PazientiTable _pazienteIdTable(_$AppDatabase db) =>
      db.pazienti.createAlias(
          $_aliasNameGenerator(db.misurazioni.pazienteId, db.pazienti.id));

  $$PazientiTableProcessedTableManager get pazienteId {
    final $_column = $_itemColumn<int>('paziente_id')!;

    final manager = $$PazientiTableTableManager($_db, $_db.pazienti)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_pazienteIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $CatalogoParametriTable _parametroIdTable(_$AppDatabase db) =>
      db.catalogoParametri.createAlias($_aliasNameGenerator(
          db.misurazioni.parametroId, db.catalogoParametri.id));

  $$CatalogoParametriTableProcessedTableManager get parametroId {
    final $_column = $_itemColumn<int>('parametro_id')!;

    final manager =
        $$CatalogoParametriTableTableManager($_db, $_db.catalogoParametri)
            .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_parametroIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$MisurazioniTableFilterComposer
    extends Composer<_$AppDatabase, $MisurazioniTable> {
  $$MisurazioniTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get valore1 => $composableBuilder(
      column: $table.valore1, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get valore2 => $composableBuilder(
      column: $table.valore2, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get valoreTesto => $composableBuilder(
      column: $table.valoreTesto, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get data => $composableBuilder(
      column: $table.data, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<FonteParametro, FonteParametro, int>
      get fonteEffettiva => $composableBuilder(
          column: $table.fonteEffettiva,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<bool> get sincronizzato => $composableBuilder(
      column: $table.sincronizzato, builder: (column) => ColumnFilters(column));

  $$PazientiTableFilterComposer get pazienteId {
    final $$PazientiTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.pazienteId,
        referencedTable: $db.pazienti,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PazientiTableFilterComposer(
              $db: $db,
              $table: $db.pazienti,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$CatalogoParametriTableFilterComposer get parametroId {
    final $$CatalogoParametriTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.parametroId,
        referencedTable: $db.catalogoParametri,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CatalogoParametriTableFilterComposer(
              $db: $db,
              $table: $db.catalogoParametri,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$MisurazioniTableOrderingComposer
    extends Composer<_$AppDatabase, $MisurazioniTable> {
  $$MisurazioniTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get valore1 => $composableBuilder(
      column: $table.valore1, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get valore2 => $composableBuilder(
      column: $table.valore2, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get valoreTesto => $composableBuilder(
      column: $table.valoreTesto, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get data => $composableBuilder(
      column: $table.data, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get fonteEffettiva => $composableBuilder(
      column: $table.fonteEffettiva,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get sincronizzato => $composableBuilder(
      column: $table.sincronizzato,
      builder: (column) => ColumnOrderings(column));

  $$PazientiTableOrderingComposer get pazienteId {
    final $$PazientiTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.pazienteId,
        referencedTable: $db.pazienti,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PazientiTableOrderingComposer(
              $db: $db,
              $table: $db.pazienti,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$CatalogoParametriTableOrderingComposer get parametroId {
    final $$CatalogoParametriTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.parametroId,
        referencedTable: $db.catalogoParametri,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CatalogoParametriTableOrderingComposer(
              $db: $db,
              $table: $db.catalogoParametri,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$MisurazioniTableAnnotationComposer
    extends Composer<_$AppDatabase, $MisurazioniTable> {
  $$MisurazioniTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get valore1 =>
      $composableBuilder(column: $table.valore1, builder: (column) => column);

  GeneratedColumn<double> get valore2 =>
      $composableBuilder(column: $table.valore2, builder: (column) => column);

  GeneratedColumn<String> get valoreTesto => $composableBuilder(
      column: $table.valoreTesto, builder: (column) => column);

  GeneratedColumn<DateTime> get data =>
      $composableBuilder(column: $table.data, builder: (column) => column);

  GeneratedColumnWithTypeConverter<FonteParametro, int> get fonteEffettiva =>
      $composableBuilder(
          column: $table.fonteEffettiva, builder: (column) => column);

  GeneratedColumn<bool> get sincronizzato => $composableBuilder(
      column: $table.sincronizzato, builder: (column) => column);

  $$PazientiTableAnnotationComposer get pazienteId {
    final $$PazientiTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.pazienteId,
        referencedTable: $db.pazienti,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PazientiTableAnnotationComposer(
              $db: $db,
              $table: $db.pazienti,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$CatalogoParametriTableAnnotationComposer get parametroId {
    final $$CatalogoParametriTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.parametroId,
            referencedTable: $db.catalogoParametri,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$CatalogoParametriTableAnnotationComposer(
                  $db: $db,
                  $table: $db.catalogoParametri,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return composer;
  }
}

class $$MisurazioniTableTableManager extends RootTableManager<
    _$AppDatabase,
    $MisurazioniTable,
    Misurazione,
    $$MisurazioniTableFilterComposer,
    $$MisurazioniTableOrderingComposer,
    $$MisurazioniTableAnnotationComposer,
    $$MisurazioniTableCreateCompanionBuilder,
    $$MisurazioniTableUpdateCompanionBuilder,
    (Misurazione, $$MisurazioniTableReferences),
    Misurazione,
    PrefetchHooks Function({bool pazienteId, bool parametroId})> {
  $$MisurazioniTableTableManager(_$AppDatabase db, $MisurazioniTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MisurazioniTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MisurazioniTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MisurazioniTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> pazienteId = const Value.absent(),
            Value<int> parametroId = const Value.absent(),
            Value<double?> valore1 = const Value.absent(),
            Value<double?> valore2 = const Value.absent(),
            Value<String?> valoreTesto = const Value.absent(),
            Value<DateTime> data = const Value.absent(),
            Value<FonteParametro> fonteEffettiva = const Value.absent(),
            Value<bool> sincronizzato = const Value.absent(),
          }) =>
              MisurazioniCompanion(
            id: id,
            pazienteId: pazienteId,
            parametroId: parametroId,
            valore1: valore1,
            valore2: valore2,
            valoreTesto: valoreTesto,
            data: data,
            fonteEffettiva: fonteEffettiva,
            sincronizzato: sincronizzato,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int pazienteId,
            required int parametroId,
            Value<double?> valore1 = const Value.absent(),
            Value<double?> valore2 = const Value.absent(),
            Value<String?> valoreTesto = const Value.absent(),
            required DateTime data,
            required FonteParametro fonteEffettiva,
            Value<bool> sincronizzato = const Value.absent(),
          }) =>
              MisurazioniCompanion.insert(
            id: id,
            pazienteId: pazienteId,
            parametroId: parametroId,
            valore1: valore1,
            valore2: valore2,
            valoreTesto: valoreTesto,
            data: data,
            fonteEffettiva: fonteEffettiva,
            sincronizzato: sincronizzato,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$MisurazioniTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({pazienteId = false, parametroId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (pazienteId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.pazienteId,
                    referencedTable:
                        $$MisurazioniTableReferences._pazienteIdTable(db),
                    referencedColumn:
                        $$MisurazioniTableReferences._pazienteIdTable(db).id,
                  ) as T;
                }
                if (parametroId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.parametroId,
                    referencedTable:
                        $$MisurazioniTableReferences._parametroIdTable(db),
                    referencedColumn:
                        $$MisurazioniTableReferences._parametroIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$MisurazioniTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $MisurazioniTable,
    Misurazione,
    $$MisurazioniTableFilterComposer,
    $$MisurazioniTableOrderingComposer,
    $$MisurazioniTableAnnotationComposer,
    $$MisurazioniTableCreateCompanionBuilder,
    $$MisurazioniTableUpdateCompanionBuilder,
    (Misurazione, $$MisurazioniTableReferences),
    Misurazione,
    PrefetchHooks Function({bool pazienteId, bool parametroId})>;
typedef $$TemplateRefertiTableCreateCompanionBuilder = TemplateRefertiCompanion
    Function({
  Value<int> id,
  required String nomeLaboratorio,
  required int parametroId,
  required String patternRicerca,
  Value<int> posizioneValore,
});
typedef $$TemplateRefertiTableUpdateCompanionBuilder = TemplateRefertiCompanion
    Function({
  Value<int> id,
  Value<String> nomeLaboratorio,
  Value<int> parametroId,
  Value<String> patternRicerca,
  Value<int> posizioneValore,
});

final class $$TemplateRefertiTableReferences extends BaseReferences<
    _$AppDatabase, $TemplateRefertiTable, TemplateReferto> {
  $$TemplateRefertiTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $CatalogoParametriTable _parametroIdTable(_$AppDatabase db) =>
      db.catalogoParametri.createAlias($_aliasNameGenerator(
          db.templateReferti.parametroId, db.catalogoParametri.id));

  $$CatalogoParametriTableProcessedTableManager get parametroId {
    final $_column = $_itemColumn<int>('parametro_id')!;

    final manager =
        $$CatalogoParametriTableTableManager($_db, $_db.catalogoParametri)
            .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_parametroIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$TemplateRefertiTableFilterComposer
    extends Composer<_$AppDatabase, $TemplateRefertiTable> {
  $$TemplateRefertiTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get nomeLaboratorio => $composableBuilder(
      column: $table.nomeLaboratorio,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get patternRicerca => $composableBuilder(
      column: $table.patternRicerca,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get posizioneValore => $composableBuilder(
      column: $table.posizioneValore,
      builder: (column) => ColumnFilters(column));

  $$CatalogoParametriTableFilterComposer get parametroId {
    final $$CatalogoParametriTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.parametroId,
        referencedTable: $db.catalogoParametri,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CatalogoParametriTableFilterComposer(
              $db: $db,
              $table: $db.catalogoParametri,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$TemplateRefertiTableOrderingComposer
    extends Composer<_$AppDatabase, $TemplateRefertiTable> {
  $$TemplateRefertiTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get nomeLaboratorio => $composableBuilder(
      column: $table.nomeLaboratorio,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get patternRicerca => $composableBuilder(
      column: $table.patternRicerca,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get posizioneValore => $composableBuilder(
      column: $table.posizioneValore,
      builder: (column) => ColumnOrderings(column));

  $$CatalogoParametriTableOrderingComposer get parametroId {
    final $$CatalogoParametriTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.parametroId,
        referencedTable: $db.catalogoParametri,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CatalogoParametriTableOrderingComposer(
              $db: $db,
              $table: $db.catalogoParametri,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$TemplateRefertiTableAnnotationComposer
    extends Composer<_$AppDatabase, $TemplateRefertiTable> {
  $$TemplateRefertiTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nomeLaboratorio => $composableBuilder(
      column: $table.nomeLaboratorio, builder: (column) => column);

  GeneratedColumn<String> get patternRicerca => $composableBuilder(
      column: $table.patternRicerca, builder: (column) => column);

  GeneratedColumn<int> get posizioneValore => $composableBuilder(
      column: $table.posizioneValore, builder: (column) => column);

  $$CatalogoParametriTableAnnotationComposer get parametroId {
    final $$CatalogoParametriTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.parametroId,
            referencedTable: $db.catalogoParametri,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$CatalogoParametriTableAnnotationComposer(
                  $db: $db,
                  $table: $db.catalogoParametri,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return composer;
  }
}

class $$TemplateRefertiTableTableManager extends RootTableManager<
    _$AppDatabase,
    $TemplateRefertiTable,
    TemplateReferto,
    $$TemplateRefertiTableFilterComposer,
    $$TemplateRefertiTableOrderingComposer,
    $$TemplateRefertiTableAnnotationComposer,
    $$TemplateRefertiTableCreateCompanionBuilder,
    $$TemplateRefertiTableUpdateCompanionBuilder,
    (TemplateReferto, $$TemplateRefertiTableReferences),
    TemplateReferto,
    PrefetchHooks Function({bool parametroId})> {
  $$TemplateRefertiTableTableManager(
      _$AppDatabase db, $TemplateRefertiTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TemplateRefertiTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TemplateRefertiTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TemplateRefertiTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> nomeLaboratorio = const Value.absent(),
            Value<int> parametroId = const Value.absent(),
            Value<String> patternRicerca = const Value.absent(),
            Value<int> posizioneValore = const Value.absent(),
          }) =>
              TemplateRefertiCompanion(
            id: id,
            nomeLaboratorio: nomeLaboratorio,
            parametroId: parametroId,
            patternRicerca: patternRicerca,
            posizioneValore: posizioneValore,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String nomeLaboratorio,
            required int parametroId,
            required String patternRicerca,
            Value<int> posizioneValore = const Value.absent(),
          }) =>
              TemplateRefertiCompanion.insert(
            id: id,
            nomeLaboratorio: nomeLaboratorio,
            parametroId: parametroId,
            patternRicerca: patternRicerca,
            posizioneValore: posizioneValore,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$TemplateRefertiTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({parametroId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (parametroId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.parametroId,
                    referencedTable:
                        $$TemplateRefertiTableReferences._parametroIdTable(db),
                    referencedColumn: $$TemplateRefertiTableReferences
                        ._parametroIdTable(db)
                        .id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$TemplateRefertiTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $TemplateRefertiTable,
    TemplateReferto,
    $$TemplateRefertiTableFilterComposer,
    $$TemplateRefertiTableOrderingComposer,
    $$TemplateRefertiTableAnnotationComposer,
    $$TemplateRefertiTableCreateCompanionBuilder,
    $$TemplateRefertiTableUpdateCompanionBuilder,
    (TemplateReferto, $$TemplateRefertiTableReferences),
    TemplateReferto,
    PrefetchHooks Function({bool parametroId})>;
typedef $$TerapieTableCreateCompanionBuilder = TerapieCompanion Function({
  Value<int> id,
  required int pazienteId,
  Value<int?> patologiaId,
  required String nomeFarmaco,
  Value<String?> dosaggio,
  required PrioritaTerapia priorita,
  Value<String?> fotoBlisterPath,
  Value<bool> attiva,
  required DateTime dataInizio,
  Value<DateTime?> dataFine,
  Value<String?> note,
});
typedef $$TerapieTableUpdateCompanionBuilder = TerapieCompanion Function({
  Value<int> id,
  Value<int> pazienteId,
  Value<int?> patologiaId,
  Value<String> nomeFarmaco,
  Value<String?> dosaggio,
  Value<PrioritaTerapia> priorita,
  Value<String?> fotoBlisterPath,
  Value<bool> attiva,
  Value<DateTime> dataInizio,
  Value<DateTime?> dataFine,
  Value<String?> note,
});

final class $$TerapieTableReferences
    extends BaseReferences<_$AppDatabase, $TerapieTable, Terapia> {
  $$TerapieTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $PazientiTable _pazienteIdTable(_$AppDatabase db) => db.pazienti
      .createAlias($_aliasNameGenerator(db.terapie.pazienteId, db.pazienti.id));

  $$PazientiTableProcessedTableManager get pazienteId {
    final $_column = $_itemColumn<int>('paziente_id')!;

    final manager = $$PazientiTableTableManager($_db, $_db.pazienti)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_pazienteIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $PatologieTable _patologiaIdTable(_$AppDatabase db) =>
      db.patologie.createAlias(
          $_aliasNameGenerator(db.terapie.patologiaId, db.patologie.id));

  $$PatologieTableProcessedTableManager? get patologiaId {
    final $_column = $_itemColumn<int>('patologia_id');
    if ($_column == null) return null;
    final manager = $$PatologieTableTableManager($_db, $_db.patologie)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_patologiaIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$OrariTerapiaTable, List<OrarioTerapia>>
      _orariTerapiaRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
          db.orariTerapia,
          aliasName:
              $_aliasNameGenerator(db.terapie.id, db.orariTerapia.terapiaId));

  $$OrariTerapiaTableProcessedTableManager get orariTerapiaRefs {
    final manager = $$OrariTerapiaTableTableManager($_db, $_db.orariTerapia)
        .filter((f) => f.terapiaId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_orariTerapiaRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$AssunzioniTable, List<Assunzione>>
      _assunzioniRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.assunzioni,
              aliasName:
                  $_aliasNameGenerator(db.terapie.id, db.assunzioni.terapiaId));

  $$AssunzioniTableProcessedTableManager get assunzioniRefs {
    final manager = $$AssunzioniTableTableManager($_db, $_db.assunzioni)
        .filter((f) => f.terapiaId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_assunzioniRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$TerapieTableFilterComposer
    extends Composer<_$AppDatabase, $TerapieTable> {
  $$TerapieTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get nomeFarmaco => $composableBuilder(
      column: $table.nomeFarmaco, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get dosaggio => $composableBuilder(
      column: $table.dosaggio, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<PrioritaTerapia, PrioritaTerapia, int>
      get priorita => $composableBuilder(
          column: $table.priorita,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<String> get fotoBlisterPath => $composableBuilder(
      column: $table.fotoBlisterPath,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get attiva => $composableBuilder(
      column: $table.attiva, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get dataInizio => $composableBuilder(
      column: $table.dataInizio, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get dataFine => $composableBuilder(
      column: $table.dataFine, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get note => $composableBuilder(
      column: $table.note, builder: (column) => ColumnFilters(column));

  $$PazientiTableFilterComposer get pazienteId {
    final $$PazientiTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.pazienteId,
        referencedTable: $db.pazienti,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PazientiTableFilterComposer(
              $db: $db,
              $table: $db.pazienti,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$PatologieTableFilterComposer get patologiaId {
    final $$PatologieTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.patologiaId,
        referencedTable: $db.patologie,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PatologieTableFilterComposer(
              $db: $db,
              $table: $db.patologie,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> orariTerapiaRefs(
      Expression<bool> Function($$OrariTerapiaTableFilterComposer f) f) {
    final $$OrariTerapiaTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.orariTerapia,
        getReferencedColumn: (t) => t.terapiaId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$OrariTerapiaTableFilterComposer(
              $db: $db,
              $table: $db.orariTerapia,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> assunzioniRefs(
      Expression<bool> Function($$AssunzioniTableFilterComposer f) f) {
    final $$AssunzioniTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.assunzioni,
        getReferencedColumn: (t) => t.terapiaId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AssunzioniTableFilterComposer(
              $db: $db,
              $table: $db.assunzioni,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$TerapieTableOrderingComposer
    extends Composer<_$AppDatabase, $TerapieTable> {
  $$TerapieTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get nomeFarmaco => $composableBuilder(
      column: $table.nomeFarmaco, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get dosaggio => $composableBuilder(
      column: $table.dosaggio, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get priorita => $composableBuilder(
      column: $table.priorita, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get fotoBlisterPath => $composableBuilder(
      column: $table.fotoBlisterPath,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get attiva => $composableBuilder(
      column: $table.attiva, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get dataInizio => $composableBuilder(
      column: $table.dataInizio, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get dataFine => $composableBuilder(
      column: $table.dataFine, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get note => $composableBuilder(
      column: $table.note, builder: (column) => ColumnOrderings(column));

  $$PazientiTableOrderingComposer get pazienteId {
    final $$PazientiTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.pazienteId,
        referencedTable: $db.pazienti,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PazientiTableOrderingComposer(
              $db: $db,
              $table: $db.pazienti,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$PatologieTableOrderingComposer get patologiaId {
    final $$PatologieTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.patologiaId,
        referencedTable: $db.patologie,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PatologieTableOrderingComposer(
              $db: $db,
              $table: $db.patologie,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$TerapieTableAnnotationComposer
    extends Composer<_$AppDatabase, $TerapieTable> {
  $$TerapieTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nomeFarmaco => $composableBuilder(
      column: $table.nomeFarmaco, builder: (column) => column);

  GeneratedColumn<String> get dosaggio =>
      $composableBuilder(column: $table.dosaggio, builder: (column) => column);

  GeneratedColumnWithTypeConverter<PrioritaTerapia, int> get priorita =>
      $composableBuilder(column: $table.priorita, builder: (column) => column);

  GeneratedColumn<String> get fotoBlisterPath => $composableBuilder(
      column: $table.fotoBlisterPath, builder: (column) => column);

  GeneratedColumn<bool> get attiva =>
      $composableBuilder(column: $table.attiva, builder: (column) => column);

  GeneratedColumn<DateTime> get dataInizio => $composableBuilder(
      column: $table.dataInizio, builder: (column) => column);

  GeneratedColumn<DateTime> get dataFine =>
      $composableBuilder(column: $table.dataFine, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  $$PazientiTableAnnotationComposer get pazienteId {
    final $$PazientiTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.pazienteId,
        referencedTable: $db.pazienti,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PazientiTableAnnotationComposer(
              $db: $db,
              $table: $db.pazienti,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$PatologieTableAnnotationComposer get patologiaId {
    final $$PatologieTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.patologiaId,
        referencedTable: $db.patologie,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PatologieTableAnnotationComposer(
              $db: $db,
              $table: $db.patologie,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> orariTerapiaRefs<T extends Object>(
      Expression<T> Function($$OrariTerapiaTableAnnotationComposer a) f) {
    final $$OrariTerapiaTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.orariTerapia,
        getReferencedColumn: (t) => t.terapiaId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$OrariTerapiaTableAnnotationComposer(
              $db: $db,
              $table: $db.orariTerapia,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> assunzioniRefs<T extends Object>(
      Expression<T> Function($$AssunzioniTableAnnotationComposer a) f) {
    final $$AssunzioniTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.assunzioni,
        getReferencedColumn: (t) => t.terapiaId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AssunzioniTableAnnotationComposer(
              $db: $db,
              $table: $db.assunzioni,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$TerapieTableTableManager extends RootTableManager<
    _$AppDatabase,
    $TerapieTable,
    Terapia,
    $$TerapieTableFilterComposer,
    $$TerapieTableOrderingComposer,
    $$TerapieTableAnnotationComposer,
    $$TerapieTableCreateCompanionBuilder,
    $$TerapieTableUpdateCompanionBuilder,
    (Terapia, $$TerapieTableReferences),
    Terapia,
    PrefetchHooks Function(
        {bool pazienteId,
        bool patologiaId,
        bool orariTerapiaRefs,
        bool assunzioniRefs})> {
  $$TerapieTableTableManager(_$AppDatabase db, $TerapieTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TerapieTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TerapieTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TerapieTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> pazienteId = const Value.absent(),
            Value<int?> patologiaId = const Value.absent(),
            Value<String> nomeFarmaco = const Value.absent(),
            Value<String?> dosaggio = const Value.absent(),
            Value<PrioritaTerapia> priorita = const Value.absent(),
            Value<String?> fotoBlisterPath = const Value.absent(),
            Value<bool> attiva = const Value.absent(),
            Value<DateTime> dataInizio = const Value.absent(),
            Value<DateTime?> dataFine = const Value.absent(),
            Value<String?> note = const Value.absent(),
          }) =>
              TerapieCompanion(
            id: id,
            pazienteId: pazienteId,
            patologiaId: patologiaId,
            nomeFarmaco: nomeFarmaco,
            dosaggio: dosaggio,
            priorita: priorita,
            fotoBlisterPath: fotoBlisterPath,
            attiva: attiva,
            dataInizio: dataInizio,
            dataFine: dataFine,
            note: note,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int pazienteId,
            Value<int?> patologiaId = const Value.absent(),
            required String nomeFarmaco,
            Value<String?> dosaggio = const Value.absent(),
            required PrioritaTerapia priorita,
            Value<String?> fotoBlisterPath = const Value.absent(),
            Value<bool> attiva = const Value.absent(),
            required DateTime dataInizio,
            Value<DateTime?> dataFine = const Value.absent(),
            Value<String?> note = const Value.absent(),
          }) =>
              TerapieCompanion.insert(
            id: id,
            pazienteId: pazienteId,
            patologiaId: patologiaId,
            nomeFarmaco: nomeFarmaco,
            dosaggio: dosaggio,
            priorita: priorita,
            fotoBlisterPath: fotoBlisterPath,
            attiva: attiva,
            dataInizio: dataInizio,
            dataFine: dataFine,
            note: note,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$TerapieTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: (
              {pazienteId = false,
              patologiaId = false,
              orariTerapiaRefs = false,
              assunzioniRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (orariTerapiaRefs) db.orariTerapia,
                if (assunzioniRefs) db.assunzioni
              ],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (pazienteId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.pazienteId,
                    referencedTable:
                        $$TerapieTableReferences._pazienteIdTable(db),
                    referencedColumn:
                        $$TerapieTableReferences._pazienteIdTable(db).id,
                  ) as T;
                }
                if (patologiaId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.patologiaId,
                    referencedTable:
                        $$TerapieTableReferences._patologiaIdTable(db),
                    referencedColumn:
                        $$TerapieTableReferences._patologiaIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (orariTerapiaRefs)
                    await $_getPrefetchedData<Terapia, $TerapieTable,
                            OrarioTerapia>(
                        currentTable: table,
                        referencedTable:
                            $$TerapieTableReferences._orariTerapiaRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$TerapieTableReferences(db, table, p0)
                                .orariTerapiaRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.terapiaId == item.id),
                        typedResults: items),
                  if (assunzioniRefs)
                    await $_getPrefetchedData<Terapia, $TerapieTable,
                            Assunzione>(
                        currentTable: table,
                        referencedTable:
                            $$TerapieTableReferences._assunzioniRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$TerapieTableReferences(db, table, p0)
                                .assunzioniRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.terapiaId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$TerapieTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $TerapieTable,
    Terapia,
    $$TerapieTableFilterComposer,
    $$TerapieTableOrderingComposer,
    $$TerapieTableAnnotationComposer,
    $$TerapieTableCreateCompanionBuilder,
    $$TerapieTableUpdateCompanionBuilder,
    (Terapia, $$TerapieTableReferences),
    Terapia,
    PrefetchHooks Function(
        {bool pazienteId,
        bool patologiaId,
        bool orariTerapiaRefs,
        bool assunzioniRefs})>;
typedef $$OrariTerapiaTableCreateCompanionBuilder = OrariTerapiaCompanion
    Function({
  Value<int> id,
  required int terapiaId,
  required String ora,
});
typedef $$OrariTerapiaTableUpdateCompanionBuilder = OrariTerapiaCompanion
    Function({
  Value<int> id,
  Value<int> terapiaId,
  Value<String> ora,
});

final class $$OrariTerapiaTableReferences
    extends BaseReferences<_$AppDatabase, $OrariTerapiaTable, OrarioTerapia> {
  $$OrariTerapiaTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $TerapieTable _terapiaIdTable(_$AppDatabase db) =>
      db.terapie.createAlias(
          $_aliasNameGenerator(db.orariTerapia.terapiaId, db.terapie.id));

  $$TerapieTableProcessedTableManager get terapiaId {
    final $_column = $_itemColumn<int>('terapia_id')!;

    final manager = $$TerapieTableTableManager($_db, $_db.terapie)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_terapiaIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$AssunzioniTable, List<Assunzione>>
      _assunzioniRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
          db.assunzioni,
          aliasName:
              $_aliasNameGenerator(db.orariTerapia.id, db.assunzioni.orarioId));

  $$AssunzioniTableProcessedTableManager get assunzioniRefs {
    final manager = $$AssunzioniTableTableManager($_db, $_db.assunzioni)
        .filter((f) => f.orarioId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_assunzioniRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$OrariTerapiaTableFilterComposer
    extends Composer<_$AppDatabase, $OrariTerapiaTable> {
  $$OrariTerapiaTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get ora => $composableBuilder(
      column: $table.ora, builder: (column) => ColumnFilters(column));

  $$TerapieTableFilterComposer get terapiaId {
    final $$TerapieTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.terapiaId,
        referencedTable: $db.terapie,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TerapieTableFilterComposer(
              $db: $db,
              $table: $db.terapie,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> assunzioniRefs(
      Expression<bool> Function($$AssunzioniTableFilterComposer f) f) {
    final $$AssunzioniTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.assunzioni,
        getReferencedColumn: (t) => t.orarioId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AssunzioniTableFilterComposer(
              $db: $db,
              $table: $db.assunzioni,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$OrariTerapiaTableOrderingComposer
    extends Composer<_$AppDatabase, $OrariTerapiaTable> {
  $$OrariTerapiaTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get ora => $composableBuilder(
      column: $table.ora, builder: (column) => ColumnOrderings(column));

  $$TerapieTableOrderingComposer get terapiaId {
    final $$TerapieTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.terapiaId,
        referencedTable: $db.terapie,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TerapieTableOrderingComposer(
              $db: $db,
              $table: $db.terapie,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$OrariTerapiaTableAnnotationComposer
    extends Composer<_$AppDatabase, $OrariTerapiaTable> {
  $$OrariTerapiaTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get ora =>
      $composableBuilder(column: $table.ora, builder: (column) => column);

  $$TerapieTableAnnotationComposer get terapiaId {
    final $$TerapieTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.terapiaId,
        referencedTable: $db.terapie,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TerapieTableAnnotationComposer(
              $db: $db,
              $table: $db.terapie,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> assunzioniRefs<T extends Object>(
      Expression<T> Function($$AssunzioniTableAnnotationComposer a) f) {
    final $$AssunzioniTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.assunzioni,
        getReferencedColumn: (t) => t.orarioId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AssunzioniTableAnnotationComposer(
              $db: $db,
              $table: $db.assunzioni,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$OrariTerapiaTableTableManager extends RootTableManager<
    _$AppDatabase,
    $OrariTerapiaTable,
    OrarioTerapia,
    $$OrariTerapiaTableFilterComposer,
    $$OrariTerapiaTableOrderingComposer,
    $$OrariTerapiaTableAnnotationComposer,
    $$OrariTerapiaTableCreateCompanionBuilder,
    $$OrariTerapiaTableUpdateCompanionBuilder,
    (OrarioTerapia, $$OrariTerapiaTableReferences),
    OrarioTerapia,
    PrefetchHooks Function({bool terapiaId, bool assunzioniRefs})> {
  $$OrariTerapiaTableTableManager(_$AppDatabase db, $OrariTerapiaTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$OrariTerapiaTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$OrariTerapiaTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$OrariTerapiaTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> terapiaId = const Value.absent(),
            Value<String> ora = const Value.absent(),
          }) =>
              OrariTerapiaCompanion(
            id: id,
            terapiaId: terapiaId,
            ora: ora,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int terapiaId,
            required String ora,
          }) =>
              OrariTerapiaCompanion.insert(
            id: id,
            terapiaId: terapiaId,
            ora: ora,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$OrariTerapiaTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({terapiaId = false, assunzioniRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (assunzioniRefs) db.assunzioni],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (terapiaId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.terapiaId,
                    referencedTable:
                        $$OrariTerapiaTableReferences._terapiaIdTable(db),
                    referencedColumn:
                        $$OrariTerapiaTableReferences._terapiaIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (assunzioniRefs)
                    await $_getPrefetchedData<OrarioTerapia, $OrariTerapiaTable,
                            Assunzione>(
                        currentTable: table,
                        referencedTable: $$OrariTerapiaTableReferences
                            ._assunzioniRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$OrariTerapiaTableReferences(db, table, p0)
                                .assunzioniRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.orarioId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$OrariTerapiaTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $OrariTerapiaTable,
    OrarioTerapia,
    $$OrariTerapiaTableFilterComposer,
    $$OrariTerapiaTableOrderingComposer,
    $$OrariTerapiaTableAnnotationComposer,
    $$OrariTerapiaTableCreateCompanionBuilder,
    $$OrariTerapiaTableUpdateCompanionBuilder,
    (OrarioTerapia, $$OrariTerapiaTableReferences),
    OrarioTerapia,
    PrefetchHooks Function({bool terapiaId, bool assunzioniRefs})>;
typedef $$AssunzioniTableCreateCompanionBuilder = AssunzioniCompanion Function({
  Value<int> id,
  required int terapiaId,
  Value<int?> orarioId,
  required DateTime dataOraPrevista,
  Value<DateTime?> dataOraRegistrazione,
  required StatoAssunzione stato,
  Value<String?> note,
  Value<bool> sincronizzato,
});
typedef $$AssunzioniTableUpdateCompanionBuilder = AssunzioniCompanion Function({
  Value<int> id,
  Value<int> terapiaId,
  Value<int?> orarioId,
  Value<DateTime> dataOraPrevista,
  Value<DateTime?> dataOraRegistrazione,
  Value<StatoAssunzione> stato,
  Value<String?> note,
  Value<bool> sincronizzato,
});

final class $$AssunzioniTableReferences
    extends BaseReferences<_$AppDatabase, $AssunzioniTable, Assunzione> {
  $$AssunzioniTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $TerapieTable _terapiaIdTable(_$AppDatabase db) =>
      db.terapie.createAlias(
          $_aliasNameGenerator(db.assunzioni.terapiaId, db.terapie.id));

  $$TerapieTableProcessedTableManager get terapiaId {
    final $_column = $_itemColumn<int>('terapia_id')!;

    final manager = $$TerapieTableTableManager($_db, $_db.terapie)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_terapiaIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $OrariTerapiaTable _orarioIdTable(_$AppDatabase db) =>
      db.orariTerapia.createAlias(
          $_aliasNameGenerator(db.assunzioni.orarioId, db.orariTerapia.id));

  $$OrariTerapiaTableProcessedTableManager? get orarioId {
    final $_column = $_itemColumn<int>('orario_id');
    if ($_column == null) return null;
    final manager = $$OrariTerapiaTableTableManager($_db, $_db.orariTerapia)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_orarioIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$AssunzioniTableFilterComposer
    extends Composer<_$AppDatabase, $AssunzioniTable> {
  $$AssunzioniTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get dataOraPrevista => $composableBuilder(
      column: $table.dataOraPrevista,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get dataOraRegistrazione => $composableBuilder(
      column: $table.dataOraRegistrazione,
      builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<StatoAssunzione, StatoAssunzione, int>
      get stato => $composableBuilder(
          column: $table.stato,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<String> get note => $composableBuilder(
      column: $table.note, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get sincronizzato => $composableBuilder(
      column: $table.sincronizzato, builder: (column) => ColumnFilters(column));

  $$TerapieTableFilterComposer get terapiaId {
    final $$TerapieTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.terapiaId,
        referencedTable: $db.terapie,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TerapieTableFilterComposer(
              $db: $db,
              $table: $db.terapie,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$OrariTerapiaTableFilterComposer get orarioId {
    final $$OrariTerapiaTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.orarioId,
        referencedTable: $db.orariTerapia,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$OrariTerapiaTableFilterComposer(
              $db: $db,
              $table: $db.orariTerapia,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$AssunzioniTableOrderingComposer
    extends Composer<_$AppDatabase, $AssunzioniTable> {
  $$AssunzioniTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get dataOraPrevista => $composableBuilder(
      column: $table.dataOraPrevista,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get dataOraRegistrazione => $composableBuilder(
      column: $table.dataOraRegistrazione,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get stato => $composableBuilder(
      column: $table.stato, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get note => $composableBuilder(
      column: $table.note, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get sincronizzato => $composableBuilder(
      column: $table.sincronizzato,
      builder: (column) => ColumnOrderings(column));

  $$TerapieTableOrderingComposer get terapiaId {
    final $$TerapieTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.terapiaId,
        referencedTable: $db.terapie,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TerapieTableOrderingComposer(
              $db: $db,
              $table: $db.terapie,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$OrariTerapiaTableOrderingComposer get orarioId {
    final $$OrariTerapiaTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.orarioId,
        referencedTable: $db.orariTerapia,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$OrariTerapiaTableOrderingComposer(
              $db: $db,
              $table: $db.orariTerapia,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$AssunzioniTableAnnotationComposer
    extends Composer<_$AppDatabase, $AssunzioniTable> {
  $$AssunzioniTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get dataOraPrevista => $composableBuilder(
      column: $table.dataOraPrevista, builder: (column) => column);

  GeneratedColumn<DateTime> get dataOraRegistrazione => $composableBuilder(
      column: $table.dataOraRegistrazione, builder: (column) => column);

  GeneratedColumnWithTypeConverter<StatoAssunzione, int> get stato =>
      $composableBuilder(column: $table.stato, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<bool> get sincronizzato => $composableBuilder(
      column: $table.sincronizzato, builder: (column) => column);

  $$TerapieTableAnnotationComposer get terapiaId {
    final $$TerapieTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.terapiaId,
        referencedTable: $db.terapie,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TerapieTableAnnotationComposer(
              $db: $db,
              $table: $db.terapie,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$OrariTerapiaTableAnnotationComposer get orarioId {
    final $$OrariTerapiaTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.orarioId,
        referencedTable: $db.orariTerapia,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$OrariTerapiaTableAnnotationComposer(
              $db: $db,
              $table: $db.orariTerapia,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$AssunzioniTableTableManager extends RootTableManager<
    _$AppDatabase,
    $AssunzioniTable,
    Assunzione,
    $$AssunzioniTableFilterComposer,
    $$AssunzioniTableOrderingComposer,
    $$AssunzioniTableAnnotationComposer,
    $$AssunzioniTableCreateCompanionBuilder,
    $$AssunzioniTableUpdateCompanionBuilder,
    (Assunzione, $$AssunzioniTableReferences),
    Assunzione,
    PrefetchHooks Function({bool terapiaId, bool orarioId})> {
  $$AssunzioniTableTableManager(_$AppDatabase db, $AssunzioniTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AssunzioniTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AssunzioniTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AssunzioniTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> terapiaId = const Value.absent(),
            Value<int?> orarioId = const Value.absent(),
            Value<DateTime> dataOraPrevista = const Value.absent(),
            Value<DateTime?> dataOraRegistrazione = const Value.absent(),
            Value<StatoAssunzione> stato = const Value.absent(),
            Value<String?> note = const Value.absent(),
            Value<bool> sincronizzato = const Value.absent(),
          }) =>
              AssunzioniCompanion(
            id: id,
            terapiaId: terapiaId,
            orarioId: orarioId,
            dataOraPrevista: dataOraPrevista,
            dataOraRegistrazione: dataOraRegistrazione,
            stato: stato,
            note: note,
            sincronizzato: sincronizzato,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int terapiaId,
            Value<int?> orarioId = const Value.absent(),
            required DateTime dataOraPrevista,
            Value<DateTime?> dataOraRegistrazione = const Value.absent(),
            required StatoAssunzione stato,
            Value<String?> note = const Value.absent(),
            Value<bool> sincronizzato = const Value.absent(),
          }) =>
              AssunzioniCompanion.insert(
            id: id,
            terapiaId: terapiaId,
            orarioId: orarioId,
            dataOraPrevista: dataOraPrevista,
            dataOraRegistrazione: dataOraRegistrazione,
            stato: stato,
            note: note,
            sincronizzato: sincronizzato,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$AssunzioniTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({terapiaId = false, orarioId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (terapiaId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.terapiaId,
                    referencedTable:
                        $$AssunzioniTableReferences._terapiaIdTable(db),
                    referencedColumn:
                        $$AssunzioniTableReferences._terapiaIdTable(db).id,
                  ) as T;
                }
                if (orarioId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.orarioId,
                    referencedTable:
                        $$AssunzioniTableReferences._orarioIdTable(db),
                    referencedColumn:
                        $$AssunzioniTableReferences._orarioIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$AssunzioniTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $AssunzioniTable,
    Assunzione,
    $$AssunzioniTableFilterComposer,
    $$AssunzioniTableOrderingComposer,
    $$AssunzioniTableAnnotationComposer,
    $$AssunzioniTableCreateCompanionBuilder,
    $$AssunzioniTableUpdateCompanionBuilder,
    (Assunzione, $$AssunzioniTableReferences),
    Assunzione,
    PrefetchHooks Function({bool terapiaId, bool orarioId})>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$PazientiTableTableManager get pazienti =>
      $$PazientiTableTableManager(_db, _db.pazienti);
  $$PatologieTableTableManager get patologie =>
      $$PatologieTableTableManager(_db, _db.patologie);
  $$RisposteAnamnesiTableTableManager get risposteAnamnesi =>
      $$RisposteAnamnesiTableTableManager(_db, _db.risposteAnamnesi);
  $$CatalogoParametriTableTableManager get catalogoParametri =>
      $$CatalogoParametriTableTableManager(_db, _db.catalogoParametri);
  $$ParametriAbilitatiTableTableManager get parametriAbilitati =>
      $$ParametriAbilitatiTableTableManager(_db, _db.parametriAbilitati);
  $$MisurazioniTableTableManager get misurazioni =>
      $$MisurazioniTableTableManager(_db, _db.misurazioni);
  $$TemplateRefertiTableTableManager get templateReferti =>
      $$TemplateRefertiTableTableManager(_db, _db.templateReferti);
  $$TerapieTableTableManager get terapie =>
      $$TerapieTableTableManager(_db, _db.terapie);
  $$OrariTerapiaTableTableManager get orariTerapia =>
      $$OrariTerapiaTableTableManager(_db, _db.orariTerapia);
  $$AssunzioniTableTableManager get assunzioni =>
      $$AssunzioniTableTableManager(_db, _db.assunzioni);
}
