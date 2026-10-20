///===
/// extcore/bio_seq_assembly_scaffold

pub(all) struct BioseqassemblyscaffoldPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn bio_seq_assembly_scaffold_make_point(x : Double, y : Double) -> BioseqassemblyscaffoldPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn bio_seq_assembly_scaffold_make_point3(x : Double, y : Double, z : Double) -> BioseqassemblyscaffoldPoint {
  { x, y, z, label: 0 }
}

pub fn BioseqassemblyscaffoldPoint::x(self : BioseqassemblyscaffoldPoint) -> Double { self.x }

pub fn BioseqassemblyscaffoldPoint::y(self : BioseqassemblyscaffoldPoint) -> Double { self.y }

pub fn BioseqassemblyscaffoldPoint::z(self : BioseqassemblyscaffoldPoint) -> Double { self.z }

pub fn BioseqassemblyscaffoldPoint::label(self : BioseqassemblyscaffoldPoint) -> Int { self.label }

pub fn BioseqassemblyscaffoldPoint::dist(self : BioseqassemblyscaffoldPoint, other : BioseqassemblyscaffoldPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn BioseqassemblyscaffoldPoint::add(self : BioseqassemblyscaffoldPoint, other : BioseqassemblyscaffoldPoint) -> BioseqassemblyscaffoldPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn BioseqassemblyscaffoldPoint::sub(self : BioseqassemblyscaffoldPoint, other : BioseqassemblyscaffoldPoint) -> BioseqassemblyscaffoldPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn BioseqassemblyscaffoldPoint::scale(self : BioseqassemblyscaffoldPoint, s : Double) -> BioseqassemblyscaffoldPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn BioseqassemblyscaffoldPoint::dot(self : BioseqassemblyscaffoldPoint, other : BioseqassemblyscaffoldPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn BioseqassemblyscaffoldPoint::cross(self : BioseqassemblyscaffoldPoint, other : BioseqassemblyscaffoldPoint) -> BioseqassemblyscaffoldPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn BioseqassemblyscaffoldPoint::norm(self : BioseqassemblyscaffoldPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn BioseqassemblyscaffoldPoint::normalize(self : BioseqassemblyscaffoldPoint) -> BioseqassemblyscaffoldPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn BioseqassemblyscaffoldPoint::negate(self : BioseqassemblyscaffoldPoint) -> BioseqassemblyscaffoldPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn BioseqassemblyscaffoldPoint::mid(self : BioseqassemblyscaffoldPoint, other : BioseqassemblyscaffoldPoint) -> BioseqassemblyscaffoldPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn BioseqassemblyscaffoldPoint::lerp(self : BioseqassemblyscaffoldPoint, other : BioseqassemblyscaffoldPoint, t : Double) -> BioseqassemblyscaffoldPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn BioseqassemblyscaffoldPoint::to_string(self : BioseqassemblyscaffoldPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct BioseqassemblyscaffoldSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn bio_seq_assembly_scaffold_make_series(vals : Array[Double], name : String) -> BioseqassemblyscaffoldSeries {
  { vals, name, meta: 0 }
}

pub fn BioseqassemblyscaffoldSeries::len(self : BioseqassemblyscaffoldSeries) -> Int { self.vals.length() }

pub fn BioseqassemblyscaffoldSeries::sum(self : BioseqassemblyscaffoldSeries) -> Double { @_common.sum(self.vals) }

pub fn BioseqassemblyscaffoldSeries::mean(self : BioseqassemblyscaffoldSeries) -> Double { @_common.mean(self.vals) }

pub fn BioseqassemblyscaffoldSeries::min(self : BioseqassemblyscaffoldSeries) -> Double { @_common.min(self.vals) }

pub fn BioseqassemblyscaffoldSeries::max(self : BioseqassemblyscaffoldSeries) -> Double { @_common.max(self.vals) }

pub fn BioseqassemblyscaffoldSeries::range(self : BioseqassemblyscaffoldSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn BioseqassemblyscaffoldSeries::variance(self : BioseqassemblyscaffoldSeries) -> Double { @_common.variance(self.vals) }

pub fn BioseqassemblyscaffoldSeries::std(self : BioseqassemblyscaffoldSeries) -> Double { @_common.std(self.vals) }

pub fn BioseqassemblyscaffoldSeries::median(self : BioseqassemblyscaffoldSeries) -> Double { @_common.median(self.vals) }

pub fn BioseqassemblyscaffoldSeries::scale(self : BioseqassemblyscaffoldSeries, f : Double) -> BioseqassemblyscaffoldSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn BioseqassemblyscaffoldSeries::add(self : BioseqassemblyscaffoldSeries, other : BioseqassemblyscaffoldSeries) -> BioseqassemblyscaffoldSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn BioseqassemblyscaffoldSeries::sub(self : BioseqassemblyscaffoldSeries, other : BioseqassemblyscaffoldSeries) -> BioseqassemblyscaffoldSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn BioseqassemblyscaffoldSeries::normalize(self : BioseqassemblyscaffoldSeries) -> BioseqassemblyscaffoldSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn BioseqassemblyscaffoldSeries::cumsum(self : BioseqassemblyscaffoldSeries) -> BioseqassemblyscaffoldSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn BioseqassemblyscaffoldSeries::to_string(self : BioseqassemblyscaffoldSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct BioseqassemblyscaffoldMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn bio_seq_assembly_scaffold_make_matrix(rows : Int, cols : Int, val : Double) -> BioseqassemblyscaffoldMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn bio_seq_assembly_scaffold_matrix_identity(n : Int) -> BioseqassemblyscaffoldMatrix {
  let m = bio_seq_assembly_scaffold_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn BioseqassemblyscaffoldMatrix::get(self : BioseqassemblyscaffoldMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn BioseqassemblyscaffoldMatrix::transpose(self : BioseqassemblyscaffoldMatrix) -> BioseqassemblyscaffoldMatrix {
  let result = bio_seq_assembly_scaffold_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn BioseqassemblyscaffoldMatrix::add(self : BioseqassemblyscaffoldMatrix, other : BioseqassemblyscaffoldMatrix) -> BioseqassemblyscaffoldMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = bio_seq_assembly_scaffold_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn BioseqassemblyscaffoldMatrix::scale(self : BioseqassemblyscaffoldMatrix, s : Double) -> BioseqassemblyscaffoldMatrix {
  let result = bio_seq_assembly_scaffold_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn BioseqassemblyscaffoldMatrix::multiply(self : BioseqassemblyscaffoldMatrix, other : BioseqassemblyscaffoldMatrix) -> BioseqassemblyscaffoldMatrix {
  if self.cols != other.rows { return bio_seq_assembly_scaffold_make_matrix(self.rows, other.cols, 0.0) }
  let result = bio_seq_assembly_scaffold_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn BioseqassemblyscaffoldMatrix::trace(self : BioseqassemblyscaffoldMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn BioseqassemblyscaffoldMatrix::det(self : BioseqassemblyscaffoldMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn BioseqassemblyscaffoldMatrix::norm(self : BioseqassemblyscaffoldMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn BioseqassemblyscaffoldMatrix::to_string(self : BioseqassemblyscaffoldMatrix) -> String {
  let mut result = "Mat(" + self.rows.to_string() + "x" + self.cols.to_string() + ")\n"
  let rl = if self.rows < 5 { self.rows } else { 5 }
  let cl = if self.cols < 5 { self.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + @_common.dbl(self.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct BioseqassemblyscaffoldVector {
  comps : Array[Double]
  dim : Int
}

pub fn bio_seq_assembly_scaffold_make_vector(comps : Array[Double]) -> BioseqassemblyscaffoldVector {
  { comps, dim: comps.length() }
}

pub fn bio_seq_assembly_scaffold_vector_zero(dim : Int) -> BioseqassemblyscaffoldVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn BioseqassemblyscaffoldVector::add(self : BioseqassemblyscaffoldVector, other : BioseqassemblyscaffoldVector) -> BioseqassemblyscaffoldVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn BioseqassemblyscaffoldVector::sub(self : BioseqassemblyscaffoldVector, other : BioseqassemblyscaffoldVector) -> BioseqassemblyscaffoldVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn BioseqassemblyscaffoldVector::scale(self : BioseqassemblyscaffoldVector, s : Double) -> BioseqassemblyscaffoldVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn BioseqassemblyscaffoldVector::dot(self : BioseqassemblyscaffoldVector, other : BioseqassemblyscaffoldVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn BioseqassemblyscaffoldVector::norm(self : BioseqassemblyscaffoldVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn BioseqassemblyscaffoldVector::normalize(self : BioseqassemblyscaffoldVector) -> BioseqassemblyscaffoldVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn BioseqassemblyscaffoldVector::dist(self : BioseqassemblyscaffoldVector, other : BioseqassemblyscaffoldVector) -> Double {
  self.sub(other).norm()
}

pub fn BioseqassemblyscaffoldVector::to_string(self : BioseqassemblyscaffoldVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct BioseqassemblyscaffoldFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_scaffold_frame_make(size : Int) -> BioseqassemblyscaffoldFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqassemblyscaffoldFrame::len(self : BioseqassemblyscaffoldFrame) -> Int { self.size }

pub fn BioseqassemblyscaffoldFrame::get(self : BioseqassemblyscaffoldFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqassemblyscaffoldFrame::set(self : BioseqassemblyscaffoldFrame, i : Int, v : Double) -> BioseqassemblyscaffoldFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqassemblyscaffoldFrame::sum(self : BioseqassemblyscaffoldFrame) -> Double { @_common.sum(self.data) }

pub fn BioseqassemblyscaffoldFrame::mean(self : BioseqassemblyscaffoldFrame) -> Double { @_common.mean(self.data) }

pub fn BioseqassemblyscaffoldFrame::scale(self : BioseqassemblyscaffoldFrame, f : Double) -> BioseqassemblyscaffoldFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqassemblyscaffoldFrame::add(self : BioseqassemblyscaffoldFrame, other : BioseqassemblyscaffoldFrame) -> BioseqassemblyscaffoldFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqassemblyscaffoldFrame::copy(self : BioseqassemblyscaffoldFrame) -> BioseqassemblyscaffoldFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqassemblyscaffoldFrame::fill(self : BioseqassemblyscaffoldFrame, v : Double) -> BioseqassemblyscaffoldFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqassemblyscaffoldFrame::min(self : BioseqassemblyscaffoldFrame) -> Double { @_common.min(self.data) }

pub fn BioseqassemblyscaffoldFrame::max(self : BioseqassemblyscaffoldFrame) -> Double { @_common.max(self.data) }

pub fn BioseqassemblyscaffoldFrame::to_string(self : BioseqassemblyscaffoldFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqassemblyscaffoldTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_scaffold_table_make(size : Int) -> BioseqassemblyscaffoldTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqassemblyscaffoldTable::len(self : BioseqassemblyscaffoldTable) -> Int { self.size }

pub fn BioseqassemblyscaffoldTable::get(self : BioseqassemblyscaffoldTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqassemblyscaffoldTable::set(self : BioseqassemblyscaffoldTable, i : Int, v : Double) -> BioseqassemblyscaffoldTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqassemblyscaffoldTable::sum(self : BioseqassemblyscaffoldTable) -> Double { @_common.sum(self.data) }

pub fn BioseqassemblyscaffoldTable::mean(self : BioseqassemblyscaffoldTable) -> Double { @_common.mean(self.data) }

pub fn BioseqassemblyscaffoldTable::scale(self : BioseqassemblyscaffoldTable, f : Double) -> BioseqassemblyscaffoldTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqassemblyscaffoldTable::add(self : BioseqassemblyscaffoldTable, other : BioseqassemblyscaffoldTable) -> BioseqassemblyscaffoldTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqassemblyscaffoldTable::copy(self : BioseqassemblyscaffoldTable) -> BioseqassemblyscaffoldTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqassemblyscaffoldTable::fill(self : BioseqassemblyscaffoldTable, v : Double) -> BioseqassemblyscaffoldTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqassemblyscaffoldTable::min(self : BioseqassemblyscaffoldTable) -> Double { @_common.min(self.data) }

pub fn BioseqassemblyscaffoldTable::max(self : BioseqassemblyscaffoldTable) -> Double { @_common.max(self.data) }

pub fn BioseqassemblyscaffoldTable::to_string(self : BioseqassemblyscaffoldTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqassemblyscaffoldGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_scaffold_graphn_make(size : Int) -> BioseqassemblyscaffoldGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqassemblyscaffoldGraphN::len(self : BioseqassemblyscaffoldGraphN) -> Int { self.size }

pub fn BioseqassemblyscaffoldGraphN::get(self : BioseqassemblyscaffoldGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqassemblyscaffoldGraphN::set(self : BioseqassemblyscaffoldGraphN, i : Int, v : Double) -> BioseqassemblyscaffoldGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqassemblyscaffoldGraphN::sum(self : BioseqassemblyscaffoldGraphN) -> Double { @_common.sum(self.data) }

pub fn BioseqassemblyscaffoldGraphN::mean(self : BioseqassemblyscaffoldGraphN) -> Double { @_common.mean(self.data) }

pub fn BioseqassemblyscaffoldGraphN::scale(self : BioseqassemblyscaffoldGraphN, f : Double) -> BioseqassemblyscaffoldGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqassemblyscaffoldGraphN::add(self : BioseqassemblyscaffoldGraphN, other : BioseqassemblyscaffoldGraphN) -> BioseqassemblyscaffoldGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqassemblyscaffoldGraphN::copy(self : BioseqassemblyscaffoldGraphN) -> BioseqassemblyscaffoldGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqassemblyscaffoldGraphN::fill(self : BioseqassemblyscaffoldGraphN, v : Double) -> BioseqassemblyscaffoldGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqassemblyscaffoldGraphN::min(self : BioseqassemblyscaffoldGraphN) -> Double { @_common.min(self.data) }

pub fn BioseqassemblyscaffoldGraphN::max(self : BioseqassemblyscaffoldGraphN) -> Double { @_common.max(self.data) }

pub fn BioseqassemblyscaffoldGraphN::to_string(self : BioseqassemblyscaffoldGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqassemblyscaffoldNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_scaffold_node_make(size : Int) -> BioseqassemblyscaffoldNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqassemblyscaffoldNode::len(self : BioseqassemblyscaffoldNode) -> Int { self.size }

pub fn BioseqassemblyscaffoldNode::get(self : BioseqassemblyscaffoldNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqassemblyscaffoldNode::set(self : BioseqassemblyscaffoldNode, i : Int, v : Double) -> BioseqassemblyscaffoldNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqassemblyscaffoldNode::sum(self : BioseqassemblyscaffoldNode) -> Double { @_common.sum(self.data) }

pub fn BioseqassemblyscaffoldNode::mean(self : BioseqassemblyscaffoldNode) -> Double { @_common.mean(self.data) }

pub fn BioseqassemblyscaffoldNode::scale(self : BioseqassemblyscaffoldNode, f : Double) -> BioseqassemblyscaffoldNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqassemblyscaffoldNode::add(self : BioseqassemblyscaffoldNode, other : BioseqassemblyscaffoldNode) -> BioseqassemblyscaffoldNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqassemblyscaffoldNode::copy(self : BioseqassemblyscaffoldNode) -> BioseqassemblyscaffoldNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqassemblyscaffoldNode::fill(self : BioseqassemblyscaffoldNode, v : Double) -> BioseqassemblyscaffoldNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqassemblyscaffoldNode::min(self : BioseqassemblyscaffoldNode) -> Double { @_common.min(self.data) }

pub fn BioseqassemblyscaffoldNode::max(self : BioseqassemblyscaffoldNode) -> Double { @_common.max(self.data) }

pub fn BioseqassemblyscaffoldNode::to_string(self : BioseqassemblyscaffoldNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqassemblyscaffoldEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_scaffold_edge_make(size : Int) -> BioseqassemblyscaffoldEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqassemblyscaffoldEdge::len(self : BioseqassemblyscaffoldEdge) -> Int { self.size }

pub fn BioseqassemblyscaffoldEdge::get(self : BioseqassemblyscaffoldEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqassemblyscaffoldEdge::set(self : BioseqassemblyscaffoldEdge, i : Int, v : Double) -> BioseqassemblyscaffoldEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqassemblyscaffoldEdge::sum(self : BioseqassemblyscaffoldEdge) -> Double { @_common.sum(self.data) }

pub fn BioseqassemblyscaffoldEdge::mean(self : BioseqassemblyscaffoldEdge) -> Double { @_common.mean(self.data) }

pub fn BioseqassemblyscaffoldEdge::scale(self : BioseqassemblyscaffoldEdge, f : Double) -> BioseqassemblyscaffoldEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqassemblyscaffoldEdge::add(self : BioseqassemblyscaffoldEdge, other : BioseqassemblyscaffoldEdge) -> BioseqassemblyscaffoldEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqassemblyscaffoldEdge::copy(self : BioseqassemblyscaffoldEdge) -> BioseqassemblyscaffoldEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqassemblyscaffoldEdge::fill(self : BioseqassemblyscaffoldEdge, v : Double) -> BioseqassemblyscaffoldEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqassemblyscaffoldEdge::min(self : BioseqassemblyscaffoldEdge) -> Double { @_common.min(self.data) }

pub fn BioseqassemblyscaffoldEdge::max(self : BioseqassemblyscaffoldEdge) -> Double { @_common.max(self.data) }

pub fn BioseqassemblyscaffoldEdge::to_string(self : BioseqassemblyscaffoldEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqassemblyscaffoldPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_scaffold_path_make(size : Int) -> BioseqassemblyscaffoldPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqassemblyscaffoldPath::len(self : BioseqassemblyscaffoldPath) -> Int { self.size }

pub fn BioseqassemblyscaffoldPath::get(self : BioseqassemblyscaffoldPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqassemblyscaffoldPath::set(self : BioseqassemblyscaffoldPath, i : Int, v : Double) -> BioseqassemblyscaffoldPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqassemblyscaffoldPath::sum(self : BioseqassemblyscaffoldPath) -> Double { @_common.sum(self.data) }

pub fn BioseqassemblyscaffoldPath::mean(self : BioseqassemblyscaffoldPath) -> Double { @_common.mean(self.data) }

pub fn BioseqassemblyscaffoldPath::scale(self : BioseqassemblyscaffoldPath, f : Double) -> BioseqassemblyscaffoldPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqassemblyscaffoldPath::add(self : BioseqassemblyscaffoldPath, other : BioseqassemblyscaffoldPath) -> BioseqassemblyscaffoldPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqassemblyscaffoldPath::copy(self : BioseqassemblyscaffoldPath) -> BioseqassemblyscaffoldPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqassemblyscaffoldPath::fill(self : BioseqassemblyscaffoldPath, v : Double) -> BioseqassemblyscaffoldPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqassemblyscaffoldPath::min(self : BioseqassemblyscaffoldPath) -> Double { @_common.min(self.data) }

pub fn BioseqassemblyscaffoldPath::max(self : BioseqassemblyscaffoldPath) -> Double { @_common.max(self.data) }

pub fn BioseqassemblyscaffoldPath::to_string(self : BioseqassemblyscaffoldPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqassemblyscaffoldCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_scaffold_cluster_make(size : Int) -> BioseqassemblyscaffoldCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqassemblyscaffoldCluster::len(self : BioseqassemblyscaffoldCluster) -> Int { self.size }

pub fn BioseqassemblyscaffoldCluster::get(self : BioseqassemblyscaffoldCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqassemblyscaffoldCluster::set(self : BioseqassemblyscaffoldCluster, i : Int, v : Double) -> BioseqassemblyscaffoldCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqassemblyscaffoldCluster::sum(self : BioseqassemblyscaffoldCluster) -> Double { @_common.sum(self.data) }

pub fn BioseqassemblyscaffoldCluster::mean(self : BioseqassemblyscaffoldCluster) -> Double { @_common.mean(self.data) }

pub fn BioseqassemblyscaffoldCluster::scale(self : BioseqassemblyscaffoldCluster, f : Double) -> BioseqassemblyscaffoldCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqassemblyscaffoldCluster::add(self : BioseqassemblyscaffoldCluster, other : BioseqassemblyscaffoldCluster) -> BioseqassemblyscaffoldCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqassemblyscaffoldCluster::copy(self : BioseqassemblyscaffoldCluster) -> BioseqassemblyscaffoldCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqassemblyscaffoldCluster::fill(self : BioseqassemblyscaffoldCluster, v : Double) -> BioseqassemblyscaffoldCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqassemblyscaffoldCluster::min(self : BioseqassemblyscaffoldCluster) -> Double { @_common.min(self.data) }

pub fn BioseqassemblyscaffoldCluster::max(self : BioseqassemblyscaffoldCluster) -> Double { @_common.max(self.data) }

pub fn BioseqassemblyscaffoldCluster::to_string(self : BioseqassemblyscaffoldCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqassemblyscaffoldModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_scaffold_model_make(size : Int) -> BioseqassemblyscaffoldModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqassemblyscaffoldModel::len(self : BioseqassemblyscaffoldModel) -> Int { self.size }

pub fn BioseqassemblyscaffoldModel::get(self : BioseqassemblyscaffoldModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqassemblyscaffoldModel::set(self : BioseqassemblyscaffoldModel, i : Int, v : Double) -> BioseqassemblyscaffoldModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqassemblyscaffoldModel::sum(self : BioseqassemblyscaffoldModel) -> Double { @_common.sum(self.data) }

pub fn BioseqassemblyscaffoldModel::mean(self : BioseqassemblyscaffoldModel) -> Double { @_common.mean(self.data) }

pub fn BioseqassemblyscaffoldModel::scale(self : BioseqassemblyscaffoldModel, f : Double) -> BioseqassemblyscaffoldModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqassemblyscaffoldModel::add(self : BioseqassemblyscaffoldModel, other : BioseqassemblyscaffoldModel) -> BioseqassemblyscaffoldModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqassemblyscaffoldModel::copy(self : BioseqassemblyscaffoldModel) -> BioseqassemblyscaffoldModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqassemblyscaffoldModel::fill(self : BioseqassemblyscaffoldModel, v : Double) -> BioseqassemblyscaffoldModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqassemblyscaffoldModel::min(self : BioseqassemblyscaffoldModel) -> Double { @_common.min(self.data) }

pub fn BioseqassemblyscaffoldModel::max(self : BioseqassemblyscaffoldModel) -> Double { @_common.max(self.data) }

pub fn BioseqassemblyscaffoldModel::to_string(self : BioseqassemblyscaffoldModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqassemblyscaffoldLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_scaffold_layer_make(size : Int) -> BioseqassemblyscaffoldLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqassemblyscaffoldLayer::len(self : BioseqassemblyscaffoldLayer) -> Int { self.size }

pub fn BioseqassemblyscaffoldLayer::get(self : BioseqassemblyscaffoldLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqassemblyscaffoldLayer::set(self : BioseqassemblyscaffoldLayer, i : Int, v : Double) -> BioseqassemblyscaffoldLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqassemblyscaffoldLayer::sum(self : BioseqassemblyscaffoldLayer) -> Double { @_common.sum(self.data) }

pub fn BioseqassemblyscaffoldLayer::mean(self : BioseqassemblyscaffoldLayer) -> Double { @_common.mean(self.data) }

pub fn BioseqassemblyscaffoldLayer::scale(self : BioseqassemblyscaffoldLayer, f : Double) -> BioseqassemblyscaffoldLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqassemblyscaffoldLayer::add(self : BioseqassemblyscaffoldLayer, other : BioseqassemblyscaffoldLayer) -> BioseqassemblyscaffoldLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqassemblyscaffoldLayer::copy(self : BioseqassemblyscaffoldLayer) -> BioseqassemblyscaffoldLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqassemblyscaffoldLayer::fill(self : BioseqassemblyscaffoldLayer, v : Double) -> BioseqassemblyscaffoldLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqassemblyscaffoldLayer::min(self : BioseqassemblyscaffoldLayer) -> Double { @_common.min(self.data) }

pub fn BioseqassemblyscaffoldLayer::max(self : BioseqassemblyscaffoldLayer) -> Double { @_common.max(self.data) }

pub fn BioseqassemblyscaffoldLayer::to_string(self : BioseqassemblyscaffoldLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqassemblyscaffoldBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_scaffold_buffer_make(size : Int) -> BioseqassemblyscaffoldBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqassemblyscaffoldBuffer::len(self : BioseqassemblyscaffoldBuffer) -> Int { self.size }

pub fn BioseqassemblyscaffoldBuffer::get(self : BioseqassemblyscaffoldBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqassemblyscaffoldBuffer::set(self : BioseqassemblyscaffoldBuffer, i : Int, v : Double) -> BioseqassemblyscaffoldBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqassemblyscaffoldBuffer::sum(self : BioseqassemblyscaffoldBuffer) -> Double { @_common.sum(self.data) }

pub fn BioseqassemblyscaffoldBuffer::mean(self : BioseqassemblyscaffoldBuffer) -> Double { @_common.mean(self.data) }

pub fn BioseqassemblyscaffoldBuffer::scale(self : BioseqassemblyscaffoldBuffer, f : Double) -> BioseqassemblyscaffoldBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqassemblyscaffoldBuffer::add(self : BioseqassemblyscaffoldBuffer, other : BioseqassemblyscaffoldBuffer) -> BioseqassemblyscaffoldBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqassemblyscaffoldBuffer::copy(self : BioseqassemblyscaffoldBuffer) -> BioseqassemblyscaffoldBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqassemblyscaffoldBuffer::fill(self : BioseqassemblyscaffoldBuffer, v : Double) -> BioseqassemblyscaffoldBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqassemblyscaffoldBuffer::min(self : BioseqassemblyscaffoldBuffer) -> Double { @_common.min(self.data) }

pub fn BioseqassemblyscaffoldBuffer::max(self : BioseqassemblyscaffoldBuffer) -> Double { @_common.max(self.data) }

pub fn BioseqassemblyscaffoldBuffer::to_string(self : BioseqassemblyscaffoldBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqassemblyscaffoldCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_scaffold_cursor_make(size : Int) -> BioseqassemblyscaffoldCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqassemblyscaffoldCursor::len(self : BioseqassemblyscaffoldCursor) -> Int { self.size }

pub fn BioseqassemblyscaffoldCursor::get(self : BioseqassemblyscaffoldCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqassemblyscaffoldCursor::set(self : BioseqassemblyscaffoldCursor, i : Int, v : Double) -> BioseqassemblyscaffoldCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqassemblyscaffoldCursor::sum(self : BioseqassemblyscaffoldCursor) -> Double { @_common.sum(self.data) }

pub fn BioseqassemblyscaffoldCursor::mean(self : BioseqassemblyscaffoldCursor) -> Double { @_common.mean(self.data) }

pub fn BioseqassemblyscaffoldCursor::scale(self : BioseqassemblyscaffoldCursor, f : Double) -> BioseqassemblyscaffoldCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqassemblyscaffoldCursor::add(self : BioseqassemblyscaffoldCursor, other : BioseqassemblyscaffoldCursor) -> BioseqassemblyscaffoldCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqassemblyscaffoldCursor::copy(self : BioseqassemblyscaffoldCursor) -> BioseqassemblyscaffoldCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqassemblyscaffoldCursor::fill(self : BioseqassemblyscaffoldCursor, v : Double) -> BioseqassemblyscaffoldCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqassemblyscaffoldCursor::min(self : BioseqassemblyscaffoldCursor) -> Double { @_common.min(self.data) }

pub fn BioseqassemblyscaffoldCursor::max(self : BioseqassemblyscaffoldCursor) -> Double { @_common.max(self.data) }

pub fn BioseqassemblyscaffoldCursor::to_string(self : BioseqassemblyscaffoldCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqassemblyscaffoldView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_scaffold_view_make(size : Int) -> BioseqassemblyscaffoldView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqassemblyscaffoldView::len(self : BioseqassemblyscaffoldView) -> Int { self.size }

pub fn BioseqassemblyscaffoldView::get(self : BioseqassemblyscaffoldView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqassemblyscaffoldView::set(self : BioseqassemblyscaffoldView, i : Int, v : Double) -> BioseqassemblyscaffoldView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqassemblyscaffoldView::sum(self : BioseqassemblyscaffoldView) -> Double { @_common.sum(self.data) }

pub fn BioseqassemblyscaffoldView::mean(self : BioseqassemblyscaffoldView) -> Double { @_common.mean(self.data) }

pub fn BioseqassemblyscaffoldView::scale(self : BioseqassemblyscaffoldView, f : Double) -> BioseqassemblyscaffoldView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqassemblyscaffoldView::add(self : BioseqassemblyscaffoldView, other : BioseqassemblyscaffoldView) -> BioseqassemblyscaffoldView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqassemblyscaffoldView::copy(self : BioseqassemblyscaffoldView) -> BioseqassemblyscaffoldView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqassemblyscaffoldView::fill(self : BioseqassemblyscaffoldView, v : Double) -> BioseqassemblyscaffoldView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqassemblyscaffoldView::min(self : BioseqassemblyscaffoldView) -> Double { @_common.min(self.data) }

pub fn BioseqassemblyscaffoldView::max(self : BioseqassemblyscaffoldView) -> Double { @_common.max(self.data) }

pub fn BioseqassemblyscaffoldView::to_string(self : BioseqassemblyscaffoldView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqassemblyscaffoldRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_scaffold_range_make(size : Int) -> BioseqassemblyscaffoldRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqassemblyscaffoldRange::len(self : BioseqassemblyscaffoldRange) -> Int { self.size }

pub fn BioseqassemblyscaffoldRange::get(self : BioseqassemblyscaffoldRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqassemblyscaffoldRange::set(self : BioseqassemblyscaffoldRange, i : Int, v : Double) -> BioseqassemblyscaffoldRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqassemblyscaffoldRange::sum(self : BioseqassemblyscaffoldRange) -> Double { @_common.sum(self.data) }

pub fn BioseqassemblyscaffoldRange::mean(self : BioseqassemblyscaffoldRange) -> Double { @_common.mean(self.data) }

pub fn BioseqassemblyscaffoldRange::scale(self : BioseqassemblyscaffoldRange, f : Double) -> BioseqassemblyscaffoldRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqassemblyscaffoldRange::add(self : BioseqassemblyscaffoldRange, other : BioseqassemblyscaffoldRange) -> BioseqassemblyscaffoldRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqassemblyscaffoldRange::copy(self : BioseqassemblyscaffoldRange) -> BioseqassemblyscaffoldRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqassemblyscaffoldRange::fill(self : BioseqassemblyscaffoldRange, v : Double) -> BioseqassemblyscaffoldRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqassemblyscaffoldRange::min(self : BioseqassemblyscaffoldRange) -> Double { @_common.min(self.data) }

pub fn BioseqassemblyscaffoldRange::max(self : BioseqassemblyscaffoldRange) -> Double { @_common.max(self.data) }

pub fn BioseqassemblyscaffoldRange::to_string(self : BioseqassemblyscaffoldRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqassemblyscaffoldSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_scaffold_slice_make(size : Int) -> BioseqassemblyscaffoldSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqassemblyscaffoldSlice::len(self : BioseqassemblyscaffoldSlice) -> Int { self.size }

pub fn BioseqassemblyscaffoldSlice::get(self : BioseqassemblyscaffoldSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqassemblyscaffoldSlice::set(self : BioseqassemblyscaffoldSlice, i : Int, v : Double) -> BioseqassemblyscaffoldSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqassemblyscaffoldSlice::sum(self : BioseqassemblyscaffoldSlice) -> Double { @_common.sum(self.data) }

pub fn BioseqassemblyscaffoldSlice::mean(self : BioseqassemblyscaffoldSlice) -> Double { @_common.mean(self.data) }

pub fn BioseqassemblyscaffoldSlice::scale(self : BioseqassemblyscaffoldSlice, f : Double) -> BioseqassemblyscaffoldSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqassemblyscaffoldSlice::add(self : BioseqassemblyscaffoldSlice, other : BioseqassemblyscaffoldSlice) -> BioseqassemblyscaffoldSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqassemblyscaffoldSlice::copy(self : BioseqassemblyscaffoldSlice) -> BioseqassemblyscaffoldSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqassemblyscaffoldSlice::fill(self : BioseqassemblyscaffoldSlice, v : Double) -> BioseqassemblyscaffoldSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqassemblyscaffoldSlice::min(self : BioseqassemblyscaffoldSlice) -> Double { @_common.min(self.data) }

pub fn BioseqassemblyscaffoldSlice::max(self : BioseqassemblyscaffoldSlice) -> Double { @_common.max(self.data) }

pub fn BioseqassemblyscaffoldSlice::to_string(self : BioseqassemblyscaffoldSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

