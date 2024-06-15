import API from "./api";
import { baseURL } from "./urls";
import axios from "axios";




export const fetchEspacos = async (condominio_id) => {
  try {
    const response = await API.get(`${baseURL}/660/espaco`, {
      params: { condominio_id }
    });

    return response.data;
  } catch (error) {
    console.error('Erro ao buscar espaços:', error);
    throw error;
  }
};


//Busca espaço pelo id
export const fetchEspacoById = async (id) => {
  try {
    const response = await API.get(`${baseURL}/660/espaco/${id}`);

    return response.data;
  } catch (error) {
    console.error('Erro ao buscar dados do espaço:', error);
    throw error;
  }
};




//Buscar Titulares(Users) Apenas com condominio_id
export const fetchTitulares = async (condominio_id) => {
  try {
    const response = await API.get(`${baseURL}/660/users`, {
      params: { condominio_id },
    });
    return response.data;
  } catch (error) {
    console.error('Erro ao buscar titulares:', error);
    throw error;
  }
};






//Buscar Dependentes
export const dependente = async (condominio_id) => {
  try {
    const response = await API.get(`${baseURL}/660/dependente`, { params: { condominio_id } });
    return response.data;
  } catch (error) {
    console.error("Erro ao buscar dados do dependente:", error);
    return [];
  }
};

export const cadastrarDependente = async (param) => {
  try {
    const response = await API.post(`${baseURL}/dependente`, param);
    return response.data;
  } catch (error) {
    console.error("Erro ao cadastrar dependente:", error);
    throw error;
  }
}

export const editarDependente = async (id, param) => {
  try {
    const response = await API.put(`${baseURL}/dependente/${id}`, param);
    return response.data;
  } catch (error) {
    console.error("Erro ao editar dependente:", error);
    throw error;
  }
}

export const excluirDependente = async (id) => {
  try {
    const response = await API.delete(`${baseURL}/dependente/${id}`);
    return response.data;
  } catch (error) {
    console.error("Erro ao excluir dependente:", error);
    throw error;
  }
};


export const cadastrarApartamento = async (param) => {
  try {
    const responseApartamento = await API.post(`${baseURL}/660/blocoapartamento`, param);
    return responseApartamento.data;
  } catch (error) {
    console.error("Erro ao cadastrar apartamento:", error)

  }
}

export const cadastrarEspaco = async (param) => {
  try {
    const response = await API.post(`${baseURL}/660/espaco`, param);
    return response.data;
  } catch (error) {
    console.error("Erro ao cadastrar espaço:", error)

  }
}

/// Função para pegar a lista de manutenção
export const fetchManutencao = async () => {
  try {
    console.log('pasou aqui');
    const response = await API.get(`${baseURL}/manutencao`);
    console.log(response);
    return response.data;
  } catch (error) {
    console.error('Erro ao buscar lista de manutencao:', error);
    throw error;
  }
};

/// Função para inserir nova manutenção
export const insertManutencao = async (param) => {
  try {
    const response = await API.post(`${baseURL}/manutencao`, param);

    return response.data;
  } catch (error) {
    console.error('Erro ao buscar lista de manutencao:', error);
    throw error;
  }
};

/// Função para deletar a manutenção
export const deleteManutencao = async (param) => {
  try {
    const response = await API.delete(`${baseURL}/manutencao/${id}`);

    return response.data;
  } catch (error) {
    console.error('Erro ao deletar manutencao:', error);
    throw error;
  }
};