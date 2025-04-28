use candle_core::{Device, Tensor};
use magnus::{function, method, Error, Module, Object, Ruby};

#[magnus::wrap(class = "Candela::Tensor")]
struct RbTensor {
    inner: Tensor,
}

impl RbTensor {
    fn new(values: Vec<f64>, shape: Vec<usize>) -> Result<Self, Error> {
        // Create a tensor from values on CPU device
        let device = Device::Cpu;
        let tensor = Tensor::from_vec(values, &shape[..], &device)
            .map_err(|e| Error::new(magnus::exception::runtime_error(), e.to_string()))?;
        
        Ok(RbTensor { inner: tensor })
    }

    fn shape(&self) -> Vec<usize> {
        self.inner.dims().to_vec()
    }

    fn to_vec(&self) -> Result<Vec<f64>, Error> {
        self.inner
            .to_vec1()
            .map_err(|e| Error::new(magnus::exception::runtime_error(), e.to_string()))
    }
}

#[magnus::init]
fn init(ruby: &Ruby) -> Result<(), Error> {
    let candela = ruby.define_module("Candela")?;
    let tensor_class = candela.define_class("Tensor", ruby.class_object())?;
    
    tensor_class.define_singleton_method("new", function!(RbTensor::new, 2))?;
    tensor_class.define_method("shape", method!(RbTensor::shape, 0))?;
    tensor_class.define_method("to_vec", method!(RbTensor::to_vec, 0))?;
    
    Ok(())
}