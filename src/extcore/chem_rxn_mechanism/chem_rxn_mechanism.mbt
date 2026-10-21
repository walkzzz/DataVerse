///|
///===
/// extcore/chem_rxn_mechanism
pub(all) struct ChemrxnmechanismPoint {
  x : Double
  y : Double
  z : Double
  label : Int32
}

///|
pub fn chem_rxn_mechanism_make_point(
  x : Double,
  y : Double,
) -> ChemrxnmechanismPoint {
  { x, y, z: 0.0, label: 0, }
}

///|
pub fn chem_rxn_mechanism_make_point3(
  x : Double,
  y : Double,
  z : Double,
) -> ChemrxnmechanismPoint {
  { x, y, z, label: 0, }
}

///|
pub fn ChemrxnmechanismPoint::x(self : ChemrxnmechanismPoint) -> Double {
  self.x
}

///|
pub fn ChemrxnmechanismPoint::y(self : ChemrxnmechanismPoint) -> Double {
  self.y
}

///|
pub fn ChemrxnmechanismPoint::z(self : ChemrxnmechanismPoint) -> Double {
  self.z
}

///|
pub fn ChemrxnmechanismPoint::label(self : ChemrxnmechanismPoint) -> Int32 {
  self.label
}

///|
pub fn ChemrxnmechanismPoint::dist(
  self : ChemrxnmechanismPoint,
  other : ChemrxnmechanismPoint,
) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

///|
pub fn ChemrxnmechanismPoint::add(
  self : ChemrxnmechanismPoint,
  other : ChemrxnmechanismPoint,
) -> ChemrxnmechanismPoint {
  {
    x: self.x + other.x,
    y: self.y + other.y,
    z: self.z + other.z,
    label: self.label,
  }
}

///|
pub fn ChemrxnmechanismPoint::sub(
  self : ChemrxnmechanismPoint,
  other : ChemrxnmechanismPoint,
) -> ChemrxnmechanismPoint {
  {
    x: self.x - other.x,
    y: self.y - other.y,
    z: self.z - other.z,
    label: self.label,
  }
}

///|
pub fn ChemrxnmechanismPoint::scale(
  self : ChemrxnmechanismPoint,
  s : Double,
) -> ChemrxnmechanismPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label, }
}

///|
pub fn ChemrxnmechanismPoint::dot(
  self : ChemrxnmechanismPoint,
  other : ChemrxnmechanismPoint,
) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

///|
pub fn ChemrxnmechanismPoint::cross(
  self : ChemrxnmechanismPoint,
  other : ChemrxnmechanismPoint,
) -> ChemrxnmechanismPoint {
  {
    x: self.y * other.z - self.z * other.y,
    y: self.z * other.x - self.x * other.z,
    z: self.x * other.y - self.y * other.x,
    label: 0,
  }
}

///|
pub fn ChemrxnmechanismPoint::norm(self : ChemrxnmechanismPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

///|
pub fn ChemrxnmechanismPoint::normalize(
  self : ChemrxnmechanismPoint,
) -> ChemrxnmechanismPoint {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn ChemrxnmechanismPoint::negate(
  self : ChemrxnmechanismPoint,
) -> ChemrxnmechanismPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label, }
}

///|
pub fn ChemrxnmechanismPoint::mid(
  self : ChemrxnmechanismPoint,
  other : ChemrxnmechanismPoint,
) -> ChemrxnmechanismPoint {
  {
    x: (self.x + other.x) / 2.0,
    y: (self.y + other.y) / 2.0,
    z: (self.z + other.z) / 2.0,
    label: self.label,
  }
}

///|
pub fn ChemrxnmechanismPoint::lerp(
  self : ChemrxnmechanismPoint,
  other : ChemrxnmechanismPoint,
  t : Double,
) -> ChemrxnmechanismPoint {
  {
    x: self.x + (other.x - self.x) * t,
    y: self.y + (other.y - self.y) * t,
    z: self.z + (other.z - self.z) * t,
    label: self.label,
  }
}

///|
pub fn ChemrxnmechanismPoint::to_string(self : ChemrxnmechanismPoint) -> String {
  "(" +
  @_common.dbl(self.x) +
  ", " +
  @_common.dbl(self.y) +
  ", " +
  @_common.dbl(self.z) +
  ")[" +
  self.label.to_string() +
  "]"
}

///|
pub(all) struct ChemrxnmechanismSeries {
  vals : Array[Double]
  name : String
  meta : Int32
}

///|
pub fn chem_rxn_mechanism_make_series(
  vals : Array[Double],
  name : String,
) -> ChemrxnmechanismSeries {
  { vals, name, meta: 0, }
}

///|
pub fn ChemrxnmechanismSeries::len(self : ChemrxnmechanismSeries) -> Int32 {
  self.vals.length()
}

///|
pub fn ChemrxnmechanismSeries::sum(self : ChemrxnmechanismSeries) -> Double {
  @_common.sum(self.vals)
}

///|
pub fn ChemrxnmechanismSeries::mean(self : ChemrxnmechanismSeries) -> Double {
  @_common.mean(self.vals)
}

///|
pub fn ChemrxnmechanismSeries::min(self : ChemrxnmechanismSeries) -> Double {
  @_common.min(self.vals)
}

///|
pub fn ChemrxnmechanismSeries::max(self : ChemrxnmechanismSeries) -> Double {
  @_common.max(self.vals)
}

///|
pub fn ChemrxnmechanismSeries::range(self : ChemrxnmechanismSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

///|
pub fn ChemrxnmechanismSeries::variance(
  self : ChemrxnmechanismSeries,
) -> Double {
  @_common.variance(self.vals)
}

///|
pub fn ChemrxnmechanismSeries::std(self : ChemrxnmechanismSeries) -> Double {
  @_common.std(self.vals)
}

///|
pub fn ChemrxnmechanismSeries::median(self : ChemrxnmechanismSeries) -> Double {
  @_common.median(self.vals)
}

///|
pub fn ChemrxnmechanismSeries::scale(
  self : ChemrxnmechanismSeries,
  f : Double,
) -> ChemrxnmechanismSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta, }
}

///|
pub fn ChemrxnmechanismSeries::add(
  self : ChemrxnmechanismSeries,
  other : ChemrxnmechanismSeries,
) -> ChemrxnmechanismSeries {
  {
    vals: @_common.add_arr(self.vals, other.vals),
    name: self.name + "+" + other.name,
    meta: self.meta,
  }
}

///|
pub fn ChemrxnmechanismSeries::sub(
  self : ChemrxnmechanismSeries,
  other : ChemrxnmechanismSeries,
) -> ChemrxnmechanismSeries {
  {
    vals: @_common.sub_arr(self.vals, other.vals),
    name: self.name + "-" + other.name,
    meta: self.meta,
  }
}

///|
pub fn ChemrxnmechanismSeries::normalize(
  self : ChemrxnmechanismSeries,
) -> ChemrxnmechanismSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 {
    self
  } else {
    let result = []
    for i in 0..<self.vals.length() {
      result.push((self.vals[i] - mn) / r)
    }
    { vals: result, name: self.name, meta: self.meta, }
  }
}

///|
pub fn ChemrxnmechanismSeries::cumsum(
  self : ChemrxnmechanismSeries,
) -> ChemrxnmechanismSeries {
  {
    vals: @_common.cumsum(self.vals),
    name: self.name + "_cumsum",
    meta: self.meta,
  }
}

///|
pub fn ChemrxnmechanismSeries::to_string(
  self : ChemrxnmechanismSeries,
) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim {
    if i > 0 {
      result = result + ", "
    }
    result = result + @_common.dbl(self.vals[i])
  }
  if n > 10 {
    result + "...]"
  } else {
    result + "]"
  }
}

///|
pub(all) struct ChemrxnmechanismMatrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn chem_rxn_mechanism_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> ChemrxnmechanismMatrix {
  let data = []
  for _ in 0..<rows {
    data.push(Array::make(cols, val))
  }
  { data, rows, cols, }
}

///|
pub fn chem_rxn_mechanism_matrix_identity(n : Int32) -> ChemrxnmechanismMatrix {
  let m = chem_rxn_mechanism_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn ChemrxnmechanismMatrix::get(
  self : ChemrxnmechanismMatrix,
  i : Int32,
  j : Int32,
) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols {
    0.0
  } else {
    self.data[i][j]
  }
}

///|
pub fn ChemrxnmechanismMatrix::transpose(
  self : ChemrxnmechanismMatrix,
) -> ChemrxnmechanismMatrix {
  let result = chem_rxn_mechanism_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[j][i] = self.data[i][j]
    }
  }
  result
}

///|
pub fn ChemrxnmechanismMatrix::add(
  self : ChemrxnmechanismMatrix,
  other : ChemrxnmechanismMatrix,
) -> ChemrxnmechanismMatrix {
  if self.rows != other.rows || self.cols != other.cols {
    return self
  }
  let result = chem_rxn_mechanism_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] + other.data[i][j]
    }
  }
  result
}

///|
pub fn ChemrxnmechanismMatrix::scale(
  self : ChemrxnmechanismMatrix,
  s : Double,
) -> ChemrxnmechanismMatrix {
  let result = chem_rxn_mechanism_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] * s
    }
  }
  result
}

///|
pub fn ChemrxnmechanismMatrix::multiply(
  self : ChemrxnmechanismMatrix,
  other : ChemrxnmechanismMatrix,
) -> ChemrxnmechanismMatrix {
  if self.cols != other.rows {
    return chem_rxn_mechanism_make_matrix(self.rows, other.cols, 0.0)
  }
  let result = chem_rxn_mechanism_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols {
        result.data[i][j] = result.data[i][j] + v * other.data[k][j]
      }
    }
  }
  result
}

///|
pub fn ChemrxnmechanismMatrix::trace(self : ChemrxnmechanismMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.data[i][i]
  }
  sum
}

///|
pub fn ChemrxnmechanismMatrix::det(self : ChemrxnmechanismMatrix) -> Double {
  if self.rows != self.cols {
    0.0
  } else if self.rows == 1 {
    self.data[0][0]
  } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] *
      (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] *
      (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] *
      (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else {
    0.0
  }
}

///|
pub fn ChemrxnmechanismMatrix::norm(self : ChemrxnmechanismMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      sum = sum + self.data[i][j] * self.data[i][j]
    }
  }
  @_common.sqrt(sum)
}

///|
pub fn ChemrxnmechanismMatrix::to_string(
  self : ChemrxnmechanismMatrix,
) -> String {
  let mut result = "Mat(" +
    self.rows.to_string() +
    "x" +
    self.cols.to_string() +
    ")\n"
  let rl = if self.rows < 5 { self.rows } else { 5 }
  let cl = if self.cols < 5 { self.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl {
      if j > 0 {
        result = result + ", "
      }
      result = result + @_common.dbl(self.data[i][j])
    }
    result = result + "]\n"
  }
  result
}

///|
pub(all) struct ChemrxnmechanismVector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn chem_rxn_mechanism_make_vector(
  comps : Array[Double],
) -> ChemrxnmechanismVector {
  { comps, dim: comps.length(), }
}

///|
pub fn chem_rxn_mechanism_vector_zero(dim : Int32) -> ChemrxnmechanismVector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn ChemrxnmechanismVector::add(
  self : ChemrxnmechanismVector,
  other : ChemrxnmechanismVector,
) -> ChemrxnmechanismVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn ChemrxnmechanismVector::sub(
  self : ChemrxnmechanismVector,
  other : ChemrxnmechanismVector,
) -> ChemrxnmechanismVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn ChemrxnmechanismVector::scale(
  self : ChemrxnmechanismVector,
  s : Double,
) -> ChemrxnmechanismVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim, }
}

///|
pub fn ChemrxnmechanismVector::dot(
  self : ChemrxnmechanismVector,
  other : ChemrxnmechanismVector,
) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.comps[i] * other.comps[i]
  }
  sum
}

///|
pub fn ChemrxnmechanismVector::norm(self : ChemrxnmechanismVector) -> Double {
  self.dot(self) |> @_common.sqrt
}

///|
pub fn ChemrxnmechanismVector::normalize(
  self : ChemrxnmechanismVector,
) -> ChemrxnmechanismVector {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn ChemrxnmechanismVector::dist(
  self : ChemrxnmechanismVector,
  other : ChemrxnmechanismVector,
) -> Double {
  self.sub(other).norm()
}

///|
pub fn ChemrxnmechanismVector::to_string(
  self : ChemrxnmechanismVector,
) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim {
    if i > 0 {
      result = result + ", "
    }
    result = result + @_common.dbl(self.comps[i])
  }
  if self.dim > 10 {
    result + "...]"
  } else {
    result + "]"
  }
}

///|
pub(all) struct ChemrxnmechanismFrame {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn chem_rxn_mechanism_frame_make(size : Int32) -> ChemrxnmechanismFrame {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ChemrxnmechanismFrame::len(self : ChemrxnmechanismFrame) -> Int32 {
  self.size
}

///|
pub fn ChemrxnmechanismFrame::get(
  self : ChemrxnmechanismFrame,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ChemrxnmechanismFrame::set(
  self : ChemrxnmechanismFrame,
  i : Int32,
  v : Double,
) -> ChemrxnmechanismFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ChemrxnmechanismFrame::sum(self : ChemrxnmechanismFrame) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ChemrxnmechanismFrame::mean(self : ChemrxnmechanismFrame) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ChemrxnmechanismFrame::scale(
  self : ChemrxnmechanismFrame,
  f : Double,
) -> ChemrxnmechanismFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ChemrxnmechanismFrame::add(
  self : ChemrxnmechanismFrame,
  other : ChemrxnmechanismFrame,
) -> ChemrxnmechanismFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ChemrxnmechanismFrame::copy(
  self : ChemrxnmechanismFrame,
) -> ChemrxnmechanismFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ChemrxnmechanismFrame::fill(
  self : ChemrxnmechanismFrame,
  v : Double,
) -> ChemrxnmechanismFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ChemrxnmechanismFrame::min(self : ChemrxnmechanismFrame) -> Double {
  @_common.min(self.data)
}

///|
pub fn ChemrxnmechanismFrame::max(self : ChemrxnmechanismFrame) -> Double {
  @_common.max(self.data)
}

///|
pub fn ChemrxnmechanismFrame::to_string(self : ChemrxnmechanismFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ChemrxnmechanismTable {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn chem_rxn_mechanism_table_make(size : Int32) -> ChemrxnmechanismTable {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ChemrxnmechanismTable::len(self : ChemrxnmechanismTable) -> Int32 {
  self.size
}

///|
pub fn ChemrxnmechanismTable::get(
  self : ChemrxnmechanismTable,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ChemrxnmechanismTable::set(
  self : ChemrxnmechanismTable,
  i : Int32,
  v : Double,
) -> ChemrxnmechanismTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ChemrxnmechanismTable::sum(self : ChemrxnmechanismTable) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ChemrxnmechanismTable::mean(self : ChemrxnmechanismTable) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ChemrxnmechanismTable::scale(
  self : ChemrxnmechanismTable,
  f : Double,
) -> ChemrxnmechanismTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ChemrxnmechanismTable::add(
  self : ChemrxnmechanismTable,
  other : ChemrxnmechanismTable,
) -> ChemrxnmechanismTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ChemrxnmechanismTable::copy(
  self : ChemrxnmechanismTable,
) -> ChemrxnmechanismTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ChemrxnmechanismTable::fill(
  self : ChemrxnmechanismTable,
  v : Double,
) -> ChemrxnmechanismTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ChemrxnmechanismTable::min(self : ChemrxnmechanismTable) -> Double {
  @_common.min(self.data)
}

///|
pub fn ChemrxnmechanismTable::max(self : ChemrxnmechanismTable) -> Double {
  @_common.max(self.data)
}

///|
pub fn ChemrxnmechanismTable::to_string(self : ChemrxnmechanismTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ChemrxnmechanismGraphN {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn chem_rxn_mechanism_graphn_make(size : Int32) -> ChemrxnmechanismGraphN {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ChemrxnmechanismGraphN::len(self : ChemrxnmechanismGraphN) -> Int32 {
  self.size
}

///|
pub fn ChemrxnmechanismGraphN::get(
  self : ChemrxnmechanismGraphN,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ChemrxnmechanismGraphN::set(
  self : ChemrxnmechanismGraphN,
  i : Int32,
  v : Double,
) -> ChemrxnmechanismGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ChemrxnmechanismGraphN::sum(self : ChemrxnmechanismGraphN) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ChemrxnmechanismGraphN::mean(self : ChemrxnmechanismGraphN) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ChemrxnmechanismGraphN::scale(
  self : ChemrxnmechanismGraphN,
  f : Double,
) -> ChemrxnmechanismGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ChemrxnmechanismGraphN::add(
  self : ChemrxnmechanismGraphN,
  other : ChemrxnmechanismGraphN,
) -> ChemrxnmechanismGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ChemrxnmechanismGraphN::copy(
  self : ChemrxnmechanismGraphN,
) -> ChemrxnmechanismGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ChemrxnmechanismGraphN::fill(
  self : ChemrxnmechanismGraphN,
  v : Double,
) -> ChemrxnmechanismGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ChemrxnmechanismGraphN::min(self : ChemrxnmechanismGraphN) -> Double {
  @_common.min(self.data)
}

///|
pub fn ChemrxnmechanismGraphN::max(self : ChemrxnmechanismGraphN) -> Double {
  @_common.max(self.data)
}

///|
pub fn ChemrxnmechanismGraphN::to_string(
  self : ChemrxnmechanismGraphN,
) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ChemrxnmechanismNode {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn chem_rxn_mechanism_node_make(size : Int32) -> ChemrxnmechanismNode {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ChemrxnmechanismNode::len(self : ChemrxnmechanismNode) -> Int32 {
  self.size
}

///|
pub fn ChemrxnmechanismNode::get(
  self : ChemrxnmechanismNode,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ChemrxnmechanismNode::set(
  self : ChemrxnmechanismNode,
  i : Int32,
  v : Double,
) -> ChemrxnmechanismNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ChemrxnmechanismNode::sum(self : ChemrxnmechanismNode) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ChemrxnmechanismNode::mean(self : ChemrxnmechanismNode) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ChemrxnmechanismNode::scale(
  self : ChemrxnmechanismNode,
  f : Double,
) -> ChemrxnmechanismNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ChemrxnmechanismNode::add(
  self : ChemrxnmechanismNode,
  other : ChemrxnmechanismNode,
) -> ChemrxnmechanismNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ChemrxnmechanismNode::copy(
  self : ChemrxnmechanismNode,
) -> ChemrxnmechanismNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ChemrxnmechanismNode::fill(
  self : ChemrxnmechanismNode,
  v : Double,
) -> ChemrxnmechanismNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ChemrxnmechanismNode::min(self : ChemrxnmechanismNode) -> Double {
  @_common.min(self.data)
}

///|
pub fn ChemrxnmechanismNode::max(self : ChemrxnmechanismNode) -> Double {
  @_common.max(self.data)
}

///|
pub fn ChemrxnmechanismNode::to_string(self : ChemrxnmechanismNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ChemrxnmechanismEdge {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn chem_rxn_mechanism_edge_make(size : Int32) -> ChemrxnmechanismEdge {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ChemrxnmechanismEdge::len(self : ChemrxnmechanismEdge) -> Int32 {
  self.size
}

///|
pub fn ChemrxnmechanismEdge::get(
  self : ChemrxnmechanismEdge,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ChemrxnmechanismEdge::set(
  self : ChemrxnmechanismEdge,
  i : Int32,
  v : Double,
) -> ChemrxnmechanismEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ChemrxnmechanismEdge::sum(self : ChemrxnmechanismEdge) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ChemrxnmechanismEdge::mean(self : ChemrxnmechanismEdge) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ChemrxnmechanismEdge::scale(
  self : ChemrxnmechanismEdge,
  f : Double,
) -> ChemrxnmechanismEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ChemrxnmechanismEdge::add(
  self : ChemrxnmechanismEdge,
  other : ChemrxnmechanismEdge,
) -> ChemrxnmechanismEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ChemrxnmechanismEdge::copy(
  self : ChemrxnmechanismEdge,
) -> ChemrxnmechanismEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ChemrxnmechanismEdge::fill(
  self : ChemrxnmechanismEdge,
  v : Double,
) -> ChemrxnmechanismEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ChemrxnmechanismEdge::min(self : ChemrxnmechanismEdge) -> Double {
  @_common.min(self.data)
}

///|
pub fn ChemrxnmechanismEdge::max(self : ChemrxnmechanismEdge) -> Double {
  @_common.max(self.data)
}

///|
pub fn ChemrxnmechanismEdge::to_string(self : ChemrxnmechanismEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ChemrxnmechanismPath {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn chem_rxn_mechanism_path_make(size : Int32) -> ChemrxnmechanismPath {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ChemrxnmechanismPath::len(self : ChemrxnmechanismPath) -> Int32 {
  self.size
}

///|
pub fn ChemrxnmechanismPath::get(
  self : ChemrxnmechanismPath,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ChemrxnmechanismPath::set(
  self : ChemrxnmechanismPath,
  i : Int32,
  v : Double,
) -> ChemrxnmechanismPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ChemrxnmechanismPath::sum(self : ChemrxnmechanismPath) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ChemrxnmechanismPath::mean(self : ChemrxnmechanismPath) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ChemrxnmechanismPath::scale(
  self : ChemrxnmechanismPath,
  f : Double,
) -> ChemrxnmechanismPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ChemrxnmechanismPath::add(
  self : ChemrxnmechanismPath,
  other : ChemrxnmechanismPath,
) -> ChemrxnmechanismPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ChemrxnmechanismPath::copy(
  self : ChemrxnmechanismPath,
) -> ChemrxnmechanismPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ChemrxnmechanismPath::fill(
  self : ChemrxnmechanismPath,
  v : Double,
) -> ChemrxnmechanismPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ChemrxnmechanismPath::min(self : ChemrxnmechanismPath) -> Double {
  @_common.min(self.data)
}

///|
pub fn ChemrxnmechanismPath::max(self : ChemrxnmechanismPath) -> Double {
  @_common.max(self.data)
}

///|
pub fn ChemrxnmechanismPath::to_string(self : ChemrxnmechanismPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ChemrxnmechanismCluster {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn chem_rxn_mechanism_cluster_make(size : Int32) -> ChemrxnmechanismCluster {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ChemrxnmechanismCluster::len(self : ChemrxnmechanismCluster) -> Int32 {
  self.size
}

///|
pub fn ChemrxnmechanismCluster::get(
  self : ChemrxnmechanismCluster,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ChemrxnmechanismCluster::set(
  self : ChemrxnmechanismCluster,
  i : Int32,
  v : Double,
) -> ChemrxnmechanismCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ChemrxnmechanismCluster::sum(self : ChemrxnmechanismCluster) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ChemrxnmechanismCluster::mean(self : ChemrxnmechanismCluster) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ChemrxnmechanismCluster::scale(
  self : ChemrxnmechanismCluster,
  f : Double,
) -> ChemrxnmechanismCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ChemrxnmechanismCluster::add(
  self : ChemrxnmechanismCluster,
  other : ChemrxnmechanismCluster,
) -> ChemrxnmechanismCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ChemrxnmechanismCluster::copy(
  self : ChemrxnmechanismCluster,
) -> ChemrxnmechanismCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ChemrxnmechanismCluster::fill(
  self : ChemrxnmechanismCluster,
  v : Double,
) -> ChemrxnmechanismCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ChemrxnmechanismCluster::min(self : ChemrxnmechanismCluster) -> Double {
  @_common.min(self.data)
}

///|
pub fn ChemrxnmechanismCluster::max(self : ChemrxnmechanismCluster) -> Double {
  @_common.max(self.data)
}

///|
pub fn ChemrxnmechanismCluster::to_string(
  self : ChemrxnmechanismCluster,
) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ChemrxnmechanismModel {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn chem_rxn_mechanism_model_make(size : Int32) -> ChemrxnmechanismModel {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ChemrxnmechanismModel::len(self : ChemrxnmechanismModel) -> Int32 {
  self.size
}

///|
pub fn ChemrxnmechanismModel::get(
  self : ChemrxnmechanismModel,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ChemrxnmechanismModel::set(
  self : ChemrxnmechanismModel,
  i : Int32,
  v : Double,
) -> ChemrxnmechanismModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ChemrxnmechanismModel::sum(self : ChemrxnmechanismModel) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ChemrxnmechanismModel::mean(self : ChemrxnmechanismModel) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ChemrxnmechanismModel::scale(
  self : ChemrxnmechanismModel,
  f : Double,
) -> ChemrxnmechanismModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ChemrxnmechanismModel::add(
  self : ChemrxnmechanismModel,
  other : ChemrxnmechanismModel,
) -> ChemrxnmechanismModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ChemrxnmechanismModel::copy(
  self : ChemrxnmechanismModel,
) -> ChemrxnmechanismModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ChemrxnmechanismModel::fill(
  self : ChemrxnmechanismModel,
  v : Double,
) -> ChemrxnmechanismModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ChemrxnmechanismModel::min(self : ChemrxnmechanismModel) -> Double {
  @_common.min(self.data)
}

///|
pub fn ChemrxnmechanismModel::max(self : ChemrxnmechanismModel) -> Double {
  @_common.max(self.data)
}

///|
pub fn ChemrxnmechanismModel::to_string(self : ChemrxnmechanismModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ChemrxnmechanismLayer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn chem_rxn_mechanism_layer_make(size : Int32) -> ChemrxnmechanismLayer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ChemrxnmechanismLayer::len(self : ChemrxnmechanismLayer) -> Int32 {
  self.size
}

///|
pub fn ChemrxnmechanismLayer::get(
  self : ChemrxnmechanismLayer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ChemrxnmechanismLayer::set(
  self : ChemrxnmechanismLayer,
  i : Int32,
  v : Double,
) -> ChemrxnmechanismLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ChemrxnmechanismLayer::sum(self : ChemrxnmechanismLayer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ChemrxnmechanismLayer::mean(self : ChemrxnmechanismLayer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ChemrxnmechanismLayer::scale(
  self : ChemrxnmechanismLayer,
  f : Double,
) -> ChemrxnmechanismLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ChemrxnmechanismLayer::add(
  self : ChemrxnmechanismLayer,
  other : ChemrxnmechanismLayer,
) -> ChemrxnmechanismLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ChemrxnmechanismLayer::copy(
  self : ChemrxnmechanismLayer,
) -> ChemrxnmechanismLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ChemrxnmechanismLayer::fill(
  self : ChemrxnmechanismLayer,
  v : Double,
) -> ChemrxnmechanismLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ChemrxnmechanismLayer::min(self : ChemrxnmechanismLayer) -> Double {
  @_common.min(self.data)
}

///|
pub fn ChemrxnmechanismLayer::max(self : ChemrxnmechanismLayer) -> Double {
  @_common.max(self.data)
}

///|
pub fn ChemrxnmechanismLayer::to_string(self : ChemrxnmechanismLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ChemrxnmechanismBuffer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn chem_rxn_mechanism_buffer_make(size : Int32) -> ChemrxnmechanismBuffer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ChemrxnmechanismBuffer::len(self : ChemrxnmechanismBuffer) -> Int32 {
  self.size
}

///|
pub fn ChemrxnmechanismBuffer::get(
  self : ChemrxnmechanismBuffer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ChemrxnmechanismBuffer::set(
  self : ChemrxnmechanismBuffer,
  i : Int32,
  v : Double,
) -> ChemrxnmechanismBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ChemrxnmechanismBuffer::sum(self : ChemrxnmechanismBuffer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ChemrxnmechanismBuffer::mean(self : ChemrxnmechanismBuffer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ChemrxnmechanismBuffer::scale(
  self : ChemrxnmechanismBuffer,
  f : Double,
) -> ChemrxnmechanismBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ChemrxnmechanismBuffer::add(
  self : ChemrxnmechanismBuffer,
  other : ChemrxnmechanismBuffer,
) -> ChemrxnmechanismBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ChemrxnmechanismBuffer::copy(
  self : ChemrxnmechanismBuffer,
) -> ChemrxnmechanismBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ChemrxnmechanismBuffer::fill(
  self : ChemrxnmechanismBuffer,
  v : Double,
) -> ChemrxnmechanismBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ChemrxnmechanismBuffer::min(self : ChemrxnmechanismBuffer) -> Double {
  @_common.min(self.data)
}

///|
pub fn ChemrxnmechanismBuffer::max(self : ChemrxnmechanismBuffer) -> Double {
  @_common.max(self.data)
}

///|
pub fn ChemrxnmechanismBuffer::to_string(
  self : ChemrxnmechanismBuffer,
) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ChemrxnmechanismCursor {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn chem_rxn_mechanism_cursor_make(size : Int32) -> ChemrxnmechanismCursor {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ChemrxnmechanismCursor::len(self : ChemrxnmechanismCursor) -> Int32 {
  self.size
}

///|
pub fn ChemrxnmechanismCursor::get(
  self : ChemrxnmechanismCursor,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ChemrxnmechanismCursor::set(
  self : ChemrxnmechanismCursor,
  i : Int32,
  v : Double,
) -> ChemrxnmechanismCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ChemrxnmechanismCursor::sum(self : ChemrxnmechanismCursor) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ChemrxnmechanismCursor::mean(self : ChemrxnmechanismCursor) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ChemrxnmechanismCursor::scale(
  self : ChemrxnmechanismCursor,
  f : Double,
) -> ChemrxnmechanismCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ChemrxnmechanismCursor::add(
  self : ChemrxnmechanismCursor,
  other : ChemrxnmechanismCursor,
) -> ChemrxnmechanismCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ChemrxnmechanismCursor::copy(
  self : ChemrxnmechanismCursor,
) -> ChemrxnmechanismCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ChemrxnmechanismCursor::fill(
  self : ChemrxnmechanismCursor,
  v : Double,
) -> ChemrxnmechanismCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ChemrxnmechanismCursor::min(self : ChemrxnmechanismCursor) -> Double {
  @_common.min(self.data)
}

///|
pub fn ChemrxnmechanismCursor::max(self : ChemrxnmechanismCursor) -> Double {
  @_common.max(self.data)
}

///|
pub fn ChemrxnmechanismCursor::to_string(
  self : ChemrxnmechanismCursor,
) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ChemrxnmechanismView {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn chem_rxn_mechanism_view_make(size : Int32) -> ChemrxnmechanismView {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ChemrxnmechanismView::len(self : ChemrxnmechanismView) -> Int32 {
  self.size
}

///|
pub fn ChemrxnmechanismView::get(
  self : ChemrxnmechanismView,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ChemrxnmechanismView::set(
  self : ChemrxnmechanismView,
  i : Int32,
  v : Double,
) -> ChemrxnmechanismView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ChemrxnmechanismView::sum(self : ChemrxnmechanismView) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ChemrxnmechanismView::mean(self : ChemrxnmechanismView) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ChemrxnmechanismView::scale(
  self : ChemrxnmechanismView,
  f : Double,
) -> ChemrxnmechanismView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ChemrxnmechanismView::add(
  self : ChemrxnmechanismView,
  other : ChemrxnmechanismView,
) -> ChemrxnmechanismView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ChemrxnmechanismView::copy(
  self : ChemrxnmechanismView,
) -> ChemrxnmechanismView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ChemrxnmechanismView::fill(
  self : ChemrxnmechanismView,
  v : Double,
) -> ChemrxnmechanismView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ChemrxnmechanismView::min(self : ChemrxnmechanismView) -> Double {
  @_common.min(self.data)
}

///|
pub fn ChemrxnmechanismView::max(self : ChemrxnmechanismView) -> Double {
  @_common.max(self.data)
}

///|
pub fn ChemrxnmechanismView::to_string(self : ChemrxnmechanismView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ChemrxnmechanismRange {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn chem_rxn_mechanism_range_make(size : Int32) -> ChemrxnmechanismRange {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ChemrxnmechanismRange::len(self : ChemrxnmechanismRange) -> Int32 {
  self.size
}

///|
pub fn ChemrxnmechanismRange::get(
  self : ChemrxnmechanismRange,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ChemrxnmechanismRange::set(
  self : ChemrxnmechanismRange,
  i : Int32,
  v : Double,
) -> ChemrxnmechanismRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ChemrxnmechanismRange::sum(self : ChemrxnmechanismRange) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ChemrxnmechanismRange::mean(self : ChemrxnmechanismRange) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ChemrxnmechanismRange::scale(
  self : ChemrxnmechanismRange,
  f : Double,
) -> ChemrxnmechanismRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ChemrxnmechanismRange::add(
  self : ChemrxnmechanismRange,
  other : ChemrxnmechanismRange,
) -> ChemrxnmechanismRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ChemrxnmechanismRange::copy(
  self : ChemrxnmechanismRange,
) -> ChemrxnmechanismRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ChemrxnmechanismRange::fill(
  self : ChemrxnmechanismRange,
  v : Double,
) -> ChemrxnmechanismRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ChemrxnmechanismRange::min(self : ChemrxnmechanismRange) -> Double {
  @_common.min(self.data)
}

///|
pub fn ChemrxnmechanismRange::max(self : ChemrxnmechanismRange) -> Double {
  @_common.max(self.data)
}

///|
pub fn ChemrxnmechanismRange::to_string(self : ChemrxnmechanismRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct ChemrxnmechanismSlice {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn chem_rxn_mechanism_slice_make(size : Int32) -> ChemrxnmechanismSlice {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn ChemrxnmechanismSlice::len(self : ChemrxnmechanismSlice) -> Int32 {
  self.size
}

///|
pub fn ChemrxnmechanismSlice::get(
  self : ChemrxnmechanismSlice,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn ChemrxnmechanismSlice::set(
  self : ChemrxnmechanismSlice,
  i : Int32,
  v : Double,
) -> ChemrxnmechanismSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn ChemrxnmechanismSlice::sum(self : ChemrxnmechanismSlice) -> Double {
  @_common.sum(self.data)
}

///|
pub fn ChemrxnmechanismSlice::mean(self : ChemrxnmechanismSlice) -> Double {
  @_common.mean(self.data)
}

///|
pub fn ChemrxnmechanismSlice::scale(
  self : ChemrxnmechanismSlice,
  f : Double,
) -> ChemrxnmechanismSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn ChemrxnmechanismSlice::add(
  self : ChemrxnmechanismSlice,
  other : ChemrxnmechanismSlice,
) -> ChemrxnmechanismSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn ChemrxnmechanismSlice::copy(
  self : ChemrxnmechanismSlice,
) -> ChemrxnmechanismSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn ChemrxnmechanismSlice::fill(
  self : ChemrxnmechanismSlice,
  v : Double,
) -> ChemrxnmechanismSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn ChemrxnmechanismSlice::min(self : ChemrxnmechanismSlice) -> Double {
  @_common.min(self.data)
}

///|
pub fn ChemrxnmechanismSlice::max(self : ChemrxnmechanismSlice) -> Double {
  @_common.max(self.data)
}

///|
pub fn ChemrxnmechanismSlice::to_string(self : ChemrxnmechanismSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}
