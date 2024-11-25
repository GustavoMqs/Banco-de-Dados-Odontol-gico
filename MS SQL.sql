CREATE TABLE Especialidades (
    IDEspecialidade INT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    Descricao TEXT
);

CREATE TABLE Enderecos (
    IDEndereco INT PRIMARY KEY,
    Rua VARCHAR(255) NOT NULL,
    Numero VARCHAR(10) NOT NULL,
    Complemento VARCHAR(100),
    Bairro VARCHAR(100) NOT NULL,
    Cidade VARCHAR(100) NOT NULL,
    Estado VARCHAR(2) NOT NULL,
    CEP VARCHAR(10) NOT NULL
);

CREATE TABLE Contatos (
    IDContato INT PRIMARY KEY,
    Telefone VARCHAR(15),
    Celular VARCHAR(15),
    Email VARCHAR(255)
);

CREATE TABLE Pacientes (
    IDPaciente INT PRIMARY KEY,
    Nome VARCHAR(255) NOT NULL,
    DataNascimento DATE NOT NULL,
    CPF VARCHAR(14) NOT NULL,
    RG VARCHAR(20),
    EnderecoID INT,
    ContatoID INT,
    InformacoesMedicas TEXT,
    FOREIGN KEY (EnderecoID) REFERENCES Enderecos(IDEndereco),
    FOREIGN KEY (ContatoID) REFERENCES Contatos(IDContato)
);

CREATE TABLE Dentistas (
    IDDentista INT PRIMARY KEY,
    Nome VARCHAR(255) NOT NULL,
    CRO VARCHAR(20) NOT NULL,
    EstadoCRO VARCHAR(2) NOT NULL,
    EspecialidadeID INT,
    EnderecoID INT,
    ContatoID INT,
    FOREIGN KEY (EspecialidadeID) REFERENCES Especialidades(IDEspecialidade),
    FOREIGN KEY (EnderecoID) REFERENCES Enderecos(IDEndereco),
    FOREIGN KEY (ContatoID) REFERENCES Contatos(IDContato)
);

CREATE TABLE Agendamentos (
    IDAgendamento INT PRIMARY KEY,
    PacienteID INT,
    DentistaID INT,
    DataHora DATETIME NOT NULL,
    TipoConsulta VARCHAR(50) NOT NULL,
    Status VARCHAR(20) NOT NULL,
    Observacoes TEXT,
    FOREIGN KEY (PacienteID) REFERENCES Pacientes(IDPaciente),
    FOREIGN KEY (DentistaID) REFERENCES Dentistas(IDDentista)
);

CREATE TABLE Prontuarios (
    IDProntuario INT PRIMARY KEY,
    PacienteID INT,
    DataCriacao DATE NOT NULL,
    Observacoes TEXT,
    FOREIGN KEY (PacienteID) REFERENCES Pacientes(IDPaciente)
);

CREATE TABLE Procedimentos (
    IDProcedimento INT PRIMARY KEY,
    Nome VARCHAR(255) NOT NULL,
    Descricao TEXT NOT NULL,
    Custo DECIMAL(10, 2) NOT NULL,
    TempoDuracao INT NOT NULL -- em minutos
);

CREATE TABLE Tratamentos (
    IDTratamento INT PRIMARY KEY,
    PacienteID INT,
    ProcedimentoID INT,
    DentistaID INT,
    DataInicio DATE NOT NULL,
    DataConclusao DATE,
    ValorCobrado DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (PacienteID) REFERENCES Pacientes(IDPaciente),
    FOREIGN KEY (ProcedimentoID) REFERENCES Procedimentos(IDProcedimento),
    FOREIGN KEY (DentistaID) REFERENCES Dentistas(IDDentista)
);

CREATE TABLE Pagamentos (
    IDPagamento INT PRIMARY KEY,
    PacienteID INT,
    TratamentoID INT,
    Valor DECIMAL(10, 2) NOT NULL,
    Data DATE NOT NULL,
    FormaPagamento VARCHAR(50),
    FOREIGN KEY (PacienteID) REFERENCES Pacientes(IDPaciente),
    FOREIGN KEY (TratamentoID) REFERENCES Tratamentos(IDTratamento)
);
