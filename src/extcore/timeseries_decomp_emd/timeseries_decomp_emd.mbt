///===
/// extcore/timeseries_decomp_emd

pub(all) struct TimeseriesdecompemdPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn timeseries_decomp_emd_make_point(x : Double, y : Double) -> TimeseriesdecompemdPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn timeseries_decomp_emd_make_point3(x : Double, y : Double, z : Double) -> TimeseriesdecompemdPoint {
  { x, y, z, label: 0 }
}

pub fn TimeseriesdecompemdPoint::x(self : TimeseriesdecompemdPoint) -> Double { self.x }

pub fn TimeseriesdecompemdPoint::y(self : TimeseriesdecompemdPoint) -> Double { self.y }

pub fn TimeseriesdecompemdPoint::z(self : TimeseriesdecompemdPoint) -> Double { self.z }

pub fn TimeseriesdecompemdPoint::label(self : TimeseriesdecompemdPoint) -> Int { self.label }

pub fn TimeseriesdecompemdPoint::dist(self : TimeseriesdecompemdPoint, other : TimeseriesdecompemdPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn TimeseriesdecompemdPoint::add(self : TimeseriesdecompemdPoint, other : TimeseriesdecompemdPoint) -> TimeseriesdecompemdPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn TimeseriesdecompemdPoint::sub(self : TimeseriesdecompemdPoint, other : TimeseriesdecompemdPoint) -> TimeseriesdecompemdPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn TimeseriesdecompemdPoint::scale(self : TimeseriesdecompemdPoint, s : Double) -> TimeseriesdecompemdPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn TimeseriesdecompemdPoint::dot(self : TimeseriesdecompemdPoint, other : TimeseriesdecompemdPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn TimeseriesdecompemdPoint::cross(self : TimeseriesdecompemdPoint, other : TimeseriesdecompemdPoint) -> TimeseriesdecompemdPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn TimeseriesdecompemdPoint::norm(self : TimeseriesdecompemdPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn TimeseriesdecompemdPoint::normalize(self : TimeseriesdecompemdPoint) -> TimeseriesdecompemdPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn TimeseriesdecompemdPoint::negate(self : TimeseriesdecompemdPoint) -> TimeseriesdecompemdPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn TimeseriesdecompemdPoint::mid(self : TimeseriesdecompemdPoint, other : TimeseriesdecompemdPoint) -> TimeseriesdecompemdPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn TimeseriesdecompemdPoint::lerp(self : TimeseriesdecompemdPoint, other : TimeseriesdecompemdPoint, t : Double) -> TimeseriesdecompemdPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn TimeseriesdecompemdPoint::to_string(self : TimeseriesdecompemdPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct TimeseriesdecompemdSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn timeseries_decomp_emd_make_series(vals : Array[Double], name : String) -> TimeseriesdecompemdSeries {
  { vals, name, meta: 0 }
}

pub fn TimeseriesdecompemdSeries::len(self : TimeseriesdecompemdSeries) -> Int { self.vals.length() }

pub fn TimeseriesdecompemdSeries::sum(self : TimeseriesdecompemdSeries) -> Double { @_common.sum(self.vals) }

pub fn TimeseriesdecompemdSeries::mean(self : TimeseriesdecompemdSeries) -> Double { @_common.mean(self.vals) }

pub fn TimeseriesdecompemdSeries::min(self : TimeseriesdecompemdSeries) -> Double { @_common.min(self.vals) }

pub fn TimeseriesdecompemdSeries::max(self : TimeseriesdecompemdSeries) -> Double { @_common.max(self.vals) }

pub fn TimeseriesdecompemdSeries::range(self : TimeseriesdecompemdSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn TimeseriesdecompemdSeries::variance(self : TimeseriesdecompemdSeries) -> Double { @_common.variance(self.vals) }

pub fn TimeseriesdecompemdSeries::std(self : TimeseriesdecompemdSeries) -> Double { @_common.std(self.vals) }

pub fn TimeseriesdecompemdSeries::median(self : TimeseriesdecompemdSeries) -> Double { @_common.median(self.vals) }

pub fn TimeseriesdecompemdSeries::scale(self : TimeseriesdecompemdSeries, f : Double) -> TimeseriesdecompemdSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn TimeseriesdecompemdSeries::add(self : TimeseriesdecompemdSeries, other : TimeseriesdecompemdSeries) -> TimeseriesdecompemdSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn TimeseriesdecompemdSeries::sub(self : TimeseriesdecompemdSeries, other : TimeseriesdecompemdSeries) -> TimeseriesdecompemdSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn TimeseriesdecompemdSeries::normalize(self : TimeseriesdecompemdSeries) -> TimeseriesdecompemdSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn TimeseriesdecompemdSeries::cumsum(self : TimeseriesdecompemdSeries) -> TimeseriesdecompemdSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn TimeseriesdecompemdSeries::to_string(self : TimeseriesdecompemdSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct TimeseriesdecompemdMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn timeseries_decomp_emd_make_matrix(rows : Int, cols : Int, val : Double) -> TimeseriesdecompemdMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn timeseries_decomp_emd_matrix_identity(n : Int) -> TimeseriesdecompemdMatrix {
  let m = timeseries_decomp_emd_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn TimeseriesdecompemdMatrix::get(self : TimeseriesdecompemdMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn TimeseriesdecompemdMatrix::transpose(self : TimeseriesdecompemdMatrix) -> TimeseriesdecompemdMatrix {
  let result = timeseries_decomp_emd_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn TimeseriesdecompemdMatrix::add(self : TimeseriesdecompemdMatrix, other : TimeseriesdecompemdMatrix) -> TimeseriesdecompemdMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = timeseries_decomp_emd_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn TimeseriesdecompemdMatrix::scale(self : TimeseriesdecompemdMatrix, s : Double) -> TimeseriesdecompemdMatrix {
  let result = timeseries_decomp_emd_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn TimeseriesdecompemdMatrix::multiply(self : TimeseriesdecompemdMatrix, other : TimeseriesdecompemdMatrix) -> TimeseriesdecompemdMatrix {
  if self.cols != other.rows { return timeseries_decomp_emd_make_matrix(self.rows, other.cols, 0.0) }
  let result = timeseries_decomp_emd_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn TimeseriesdecompemdMatrix::trace(self : TimeseriesdecompemdMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn TimeseriesdecompemdMatrix::det(self : TimeseriesdecompemdMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn TimeseriesdecompemdMatrix::norm(self : TimeseriesdecompemdMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn TimeseriesdecompemdMatrix::to_string(self : TimeseriesdecompemdMatrix) -> String {
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

pub(all) struct TimeseriesdecompemdVector {
  comps : Array[Double]
  dim : Int
}

pub fn timeseries_decomp_emd_make_vector(comps : Array[Double]) -> TimeseriesdecompemdVector {
  { comps, dim: comps.length() }
}

pub fn timeseries_decomp_emd_vector_zero(dim : Int) -> TimeseriesdecompemdVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn TimeseriesdecompemdVector::add(self : TimeseriesdecompemdVector, other : TimeseriesdecompemdVector) -> TimeseriesdecompemdVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn TimeseriesdecompemdVector::sub(self : TimeseriesdecompemdVector, other : TimeseriesdecompemdVector) -> TimeseriesdecompemdVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn TimeseriesdecompemdVector::scale(self : TimeseriesdecompemdVector, s : Double) -> TimeseriesdecompemdVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn TimeseriesdecompemdVector::dot(self : TimeseriesdecompemdVector, other : TimeseriesdecompemdVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn TimeseriesdecompemdVector::norm(self : TimeseriesdecompemdVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn TimeseriesdecompemdVector::normalize(self : TimeseriesdecompemdVector) -> TimeseriesdecompemdVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn TimeseriesdecompemdVector::dist(self : TimeseriesdecompemdVector, other : TimeseriesdecompemdVector) -> Double {
  self.sub(other).norm()
}

pub fn TimeseriesdecompemdVector::to_string(self : TimeseriesdecompemdVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct TimeseriesdecompemdFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_emd_frame_make(size : Int) -> TimeseriesdecompemdFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesdecompemdFrame::len(self : TimeseriesdecompemdFrame) -> Int { self.size }

pub fn TimeseriesdecompemdFrame::get(self : TimeseriesdecompemdFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesdecompemdFrame::set(self : TimeseriesdecompemdFrame, i : Int, v : Double) -> TimeseriesdecompemdFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompemdFrame::sum(self : TimeseriesdecompemdFrame) -> Double { @_common.sum(self.data) }

pub fn TimeseriesdecompemdFrame::mean(self : TimeseriesdecompemdFrame) -> Double { @_common.mean(self.data) }

pub fn TimeseriesdecompemdFrame::scale(self : TimeseriesdecompemdFrame, f : Double) -> TimeseriesdecompemdFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompemdFrame::add(self : TimeseriesdecompemdFrame, other : TimeseriesdecompemdFrame) -> TimeseriesdecompemdFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesdecompemdFrame::copy(self : TimeseriesdecompemdFrame) -> TimeseriesdecompemdFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompemdFrame::fill(self : TimeseriesdecompemdFrame, v : Double) -> TimeseriesdecompemdFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompemdFrame::min(self : TimeseriesdecompemdFrame) -> Double { @_common.min(self.data) }

pub fn TimeseriesdecompemdFrame::max(self : TimeseriesdecompemdFrame) -> Double { @_common.max(self.data) }

pub fn TimeseriesdecompemdFrame::to_string(self : TimeseriesdecompemdFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompemdTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_emd_table_make(size : Int) -> TimeseriesdecompemdTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesdecompemdTable::len(self : TimeseriesdecompemdTable) -> Int { self.size }

pub fn TimeseriesdecompemdTable::get(self : TimeseriesdecompemdTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesdecompemdTable::set(self : TimeseriesdecompemdTable, i : Int, v : Double) -> TimeseriesdecompemdTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompemdTable::sum(self : TimeseriesdecompemdTable) -> Double { @_common.sum(self.data) }

pub fn TimeseriesdecompemdTable::mean(self : TimeseriesdecompemdTable) -> Double { @_common.mean(self.data) }

pub fn TimeseriesdecompemdTable::scale(self : TimeseriesdecompemdTable, f : Double) -> TimeseriesdecompemdTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompemdTable::add(self : TimeseriesdecompemdTable, other : TimeseriesdecompemdTable) -> TimeseriesdecompemdTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesdecompemdTable::copy(self : TimeseriesdecompemdTable) -> TimeseriesdecompemdTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompemdTable::fill(self : TimeseriesdecompemdTable, v : Double) -> TimeseriesdecompemdTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompemdTable::min(self : TimeseriesdecompemdTable) -> Double { @_common.min(self.data) }

pub fn TimeseriesdecompemdTable::max(self : TimeseriesdecompemdTable) -> Double { @_common.max(self.data) }

pub fn TimeseriesdecompemdTable::to_string(self : TimeseriesdecompemdTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompemdGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_emd_graphn_make(size : Int) -> TimeseriesdecompemdGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesdecompemdGraphN::len(self : TimeseriesdecompemdGraphN) -> Int { self.size }

pub fn TimeseriesdecompemdGraphN::get(self : TimeseriesdecompemdGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesdecompemdGraphN::set(self : TimeseriesdecompemdGraphN, i : Int, v : Double) -> TimeseriesdecompemdGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompemdGraphN::sum(self : TimeseriesdecompemdGraphN) -> Double { @_common.sum(self.data) }

pub fn TimeseriesdecompemdGraphN::mean(self : TimeseriesdecompemdGraphN) -> Double { @_common.mean(self.data) }

pub fn TimeseriesdecompemdGraphN::scale(self : TimeseriesdecompemdGraphN, f : Double) -> TimeseriesdecompemdGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompemdGraphN::add(self : TimeseriesdecompemdGraphN, other : TimeseriesdecompemdGraphN) -> TimeseriesdecompemdGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesdecompemdGraphN::copy(self : TimeseriesdecompemdGraphN) -> TimeseriesdecompemdGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompemdGraphN::fill(self : TimeseriesdecompemdGraphN, v : Double) -> TimeseriesdecompemdGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompemdGraphN::min(self : TimeseriesdecompemdGraphN) -> Double { @_common.min(self.data) }

pub fn TimeseriesdecompemdGraphN::max(self : TimeseriesdecompemdGraphN) -> Double { @_common.max(self.data) }

pub fn TimeseriesdecompemdGraphN::to_string(self : TimeseriesdecompemdGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompemdNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_emd_node_make(size : Int) -> TimeseriesdecompemdNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesdecompemdNode::len(self : TimeseriesdecompemdNode) -> Int { self.size }

pub fn TimeseriesdecompemdNode::get(self : TimeseriesdecompemdNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesdecompemdNode::set(self : TimeseriesdecompemdNode, i : Int, v : Double) -> TimeseriesdecompemdNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompemdNode::sum(self : TimeseriesdecompemdNode) -> Double { @_common.sum(self.data) }

pub fn TimeseriesdecompemdNode::mean(self : TimeseriesdecompemdNode) -> Double { @_common.mean(self.data) }

pub fn TimeseriesdecompemdNode::scale(self : TimeseriesdecompemdNode, f : Double) -> TimeseriesdecompemdNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompemdNode::add(self : TimeseriesdecompemdNode, other : TimeseriesdecompemdNode) -> TimeseriesdecompemdNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesdecompemdNode::copy(self : TimeseriesdecompemdNode) -> TimeseriesdecompemdNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompemdNode::fill(self : TimeseriesdecompemdNode, v : Double) -> TimeseriesdecompemdNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompemdNode::min(self : TimeseriesdecompemdNode) -> Double { @_common.min(self.data) }

pub fn TimeseriesdecompemdNode::max(self : TimeseriesdecompemdNode) -> Double { @_common.max(self.data) }

pub fn TimeseriesdecompemdNode::to_string(self : TimeseriesdecompemdNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompemdEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_emd_edge_make(size : Int) -> TimeseriesdecompemdEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesdecompemdEdge::len(self : TimeseriesdecompemdEdge) -> Int { self.size }

pub fn TimeseriesdecompemdEdge::get(self : TimeseriesdecompemdEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesdecompemdEdge::set(self : TimeseriesdecompemdEdge, i : Int, v : Double) -> TimeseriesdecompemdEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompemdEdge::sum(self : TimeseriesdecompemdEdge) -> Double { @_common.sum(self.data) }

pub fn TimeseriesdecompemdEdge::mean(self : TimeseriesdecompemdEdge) -> Double { @_common.mean(self.data) }

pub fn TimeseriesdecompemdEdge::scale(self : TimeseriesdecompemdEdge, f : Double) -> TimeseriesdecompemdEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompemdEdge::add(self : TimeseriesdecompemdEdge, other : TimeseriesdecompemdEdge) -> TimeseriesdecompemdEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesdecompemdEdge::copy(self : TimeseriesdecompemdEdge) -> TimeseriesdecompemdEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompemdEdge::fill(self : TimeseriesdecompemdEdge, v : Double) -> TimeseriesdecompemdEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompemdEdge::min(self : TimeseriesdecompemdEdge) -> Double { @_common.min(self.data) }

pub fn TimeseriesdecompemdEdge::max(self : TimeseriesdecompemdEdge) -> Double { @_common.max(self.data) }

pub fn TimeseriesdecompemdEdge::to_string(self : TimeseriesdecompemdEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompemdPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_emd_path_make(size : Int) -> TimeseriesdecompemdPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesdecompemdPath::len(self : TimeseriesdecompemdPath) -> Int { self.size }

pub fn TimeseriesdecompemdPath::get(self : TimeseriesdecompemdPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesdecompemdPath::set(self : TimeseriesdecompemdPath, i : Int, v : Double) -> TimeseriesdecompemdPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompemdPath::sum(self : TimeseriesdecompemdPath) -> Double { @_common.sum(self.data) }

pub fn TimeseriesdecompemdPath::mean(self : TimeseriesdecompemdPath) -> Double { @_common.mean(self.data) }

pub fn TimeseriesdecompemdPath::scale(self : TimeseriesdecompemdPath, f : Double) -> TimeseriesdecompemdPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompemdPath::add(self : TimeseriesdecompemdPath, other : TimeseriesdecompemdPath) -> TimeseriesdecompemdPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesdecompemdPath::copy(self : TimeseriesdecompemdPath) -> TimeseriesdecompemdPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompemdPath::fill(self : TimeseriesdecompemdPath, v : Double) -> TimeseriesdecompemdPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompemdPath::min(self : TimeseriesdecompemdPath) -> Double { @_common.min(self.data) }

pub fn TimeseriesdecompemdPath::max(self : TimeseriesdecompemdPath) -> Double { @_common.max(self.data) }

pub fn TimeseriesdecompemdPath::to_string(self : TimeseriesdecompemdPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompemdCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_emd_cluster_make(size : Int) -> TimeseriesdecompemdCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesdecompemdCluster::len(self : TimeseriesdecompemdCluster) -> Int { self.size }

pub fn TimeseriesdecompemdCluster::get(self : TimeseriesdecompemdCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesdecompemdCluster::set(self : TimeseriesdecompemdCluster, i : Int, v : Double) -> TimeseriesdecompemdCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompemdCluster::sum(self : TimeseriesdecompemdCluster) -> Double { @_common.sum(self.data) }

pub fn TimeseriesdecompemdCluster::mean(self : TimeseriesdecompemdCluster) -> Double { @_common.mean(self.data) }

pub fn TimeseriesdecompemdCluster::scale(self : TimeseriesdecompemdCluster, f : Double) -> TimeseriesdecompemdCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompemdCluster::add(self : TimeseriesdecompemdCluster, other : TimeseriesdecompemdCluster) -> TimeseriesdecompemdCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesdecompemdCluster::copy(self : TimeseriesdecompemdCluster) -> TimeseriesdecompemdCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompemdCluster::fill(self : TimeseriesdecompemdCluster, v : Double) -> TimeseriesdecompemdCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompemdCluster::min(self : TimeseriesdecompemdCluster) -> Double { @_common.min(self.data) }

pub fn TimeseriesdecompemdCluster::max(self : TimeseriesdecompemdCluster) -> Double { @_common.max(self.data) }

pub fn TimeseriesdecompemdCluster::to_string(self : TimeseriesdecompemdCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompemdModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_emd_model_make(size : Int) -> TimeseriesdecompemdModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesdecompemdModel::len(self : TimeseriesdecompemdModel) -> Int { self.size }

pub fn TimeseriesdecompemdModel::get(self : TimeseriesdecompemdModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesdecompemdModel::set(self : TimeseriesdecompemdModel, i : Int, v : Double) -> TimeseriesdecompemdModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompemdModel::sum(self : TimeseriesdecompemdModel) -> Double { @_common.sum(self.data) }

pub fn TimeseriesdecompemdModel::mean(self : TimeseriesdecompemdModel) -> Double { @_common.mean(self.data) }

pub fn TimeseriesdecompemdModel::scale(self : TimeseriesdecompemdModel, f : Double) -> TimeseriesdecompemdModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompemdModel::add(self : TimeseriesdecompemdModel, other : TimeseriesdecompemdModel) -> TimeseriesdecompemdModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesdecompemdModel::copy(self : TimeseriesdecompemdModel) -> TimeseriesdecompemdModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompemdModel::fill(self : TimeseriesdecompemdModel, v : Double) -> TimeseriesdecompemdModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompemdModel::min(self : TimeseriesdecompemdModel) -> Double { @_common.min(self.data) }

pub fn TimeseriesdecompemdModel::max(self : TimeseriesdecompemdModel) -> Double { @_common.max(self.data) }

pub fn TimeseriesdecompemdModel::to_string(self : TimeseriesdecompemdModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompemdLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_emd_layer_make(size : Int) -> TimeseriesdecompemdLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesdecompemdLayer::len(self : TimeseriesdecompemdLayer) -> Int { self.size }

pub fn TimeseriesdecompemdLayer::get(self : TimeseriesdecompemdLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesdecompemdLayer::set(self : TimeseriesdecompemdLayer, i : Int, v : Double) -> TimeseriesdecompemdLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompemdLayer::sum(self : TimeseriesdecompemdLayer) -> Double { @_common.sum(self.data) }

pub fn TimeseriesdecompemdLayer::mean(self : TimeseriesdecompemdLayer) -> Double { @_common.mean(self.data) }

pub fn TimeseriesdecompemdLayer::scale(self : TimeseriesdecompemdLayer, f : Double) -> TimeseriesdecompemdLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompemdLayer::add(self : TimeseriesdecompemdLayer, other : TimeseriesdecompemdLayer) -> TimeseriesdecompemdLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesdecompemdLayer::copy(self : TimeseriesdecompemdLayer) -> TimeseriesdecompemdLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompemdLayer::fill(self : TimeseriesdecompemdLayer, v : Double) -> TimeseriesdecompemdLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompemdLayer::min(self : TimeseriesdecompemdLayer) -> Double { @_common.min(self.data) }

pub fn TimeseriesdecompemdLayer::max(self : TimeseriesdecompemdLayer) -> Double { @_common.max(self.data) }

pub fn TimeseriesdecompemdLayer::to_string(self : TimeseriesdecompemdLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompemdBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_emd_buffer_make(size : Int) -> TimeseriesdecompemdBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesdecompemdBuffer::len(self : TimeseriesdecompemdBuffer) -> Int { self.size }

pub fn TimeseriesdecompemdBuffer::get(self : TimeseriesdecompemdBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesdecompemdBuffer::set(self : TimeseriesdecompemdBuffer, i : Int, v : Double) -> TimeseriesdecompemdBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompemdBuffer::sum(self : TimeseriesdecompemdBuffer) -> Double { @_common.sum(self.data) }

pub fn TimeseriesdecompemdBuffer::mean(self : TimeseriesdecompemdBuffer) -> Double { @_common.mean(self.data) }

pub fn TimeseriesdecompemdBuffer::scale(self : TimeseriesdecompemdBuffer, f : Double) -> TimeseriesdecompemdBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompemdBuffer::add(self : TimeseriesdecompemdBuffer, other : TimeseriesdecompemdBuffer) -> TimeseriesdecompemdBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesdecompemdBuffer::copy(self : TimeseriesdecompemdBuffer) -> TimeseriesdecompemdBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompemdBuffer::fill(self : TimeseriesdecompemdBuffer, v : Double) -> TimeseriesdecompemdBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompemdBuffer::min(self : TimeseriesdecompemdBuffer) -> Double { @_common.min(self.data) }

pub fn TimeseriesdecompemdBuffer::max(self : TimeseriesdecompemdBuffer) -> Double { @_common.max(self.data) }

pub fn TimeseriesdecompemdBuffer::to_string(self : TimeseriesdecompemdBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompemdCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_emd_cursor_make(size : Int) -> TimeseriesdecompemdCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesdecompemdCursor::len(self : TimeseriesdecompemdCursor) -> Int { self.size }

pub fn TimeseriesdecompemdCursor::get(self : TimeseriesdecompemdCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesdecompemdCursor::set(self : TimeseriesdecompemdCursor, i : Int, v : Double) -> TimeseriesdecompemdCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompemdCursor::sum(self : TimeseriesdecompemdCursor) -> Double { @_common.sum(self.data) }

pub fn TimeseriesdecompemdCursor::mean(self : TimeseriesdecompemdCursor) -> Double { @_common.mean(self.data) }

pub fn TimeseriesdecompemdCursor::scale(self : TimeseriesdecompemdCursor, f : Double) -> TimeseriesdecompemdCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompemdCursor::add(self : TimeseriesdecompemdCursor, other : TimeseriesdecompemdCursor) -> TimeseriesdecompemdCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesdecompemdCursor::copy(self : TimeseriesdecompemdCursor) -> TimeseriesdecompemdCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompemdCursor::fill(self : TimeseriesdecompemdCursor, v : Double) -> TimeseriesdecompemdCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompemdCursor::min(self : TimeseriesdecompemdCursor) -> Double { @_common.min(self.data) }

pub fn TimeseriesdecompemdCursor::max(self : TimeseriesdecompemdCursor) -> Double { @_common.max(self.data) }

pub fn TimeseriesdecompemdCursor::to_string(self : TimeseriesdecompemdCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompemdView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_emd_view_make(size : Int) -> TimeseriesdecompemdView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesdecompemdView::len(self : TimeseriesdecompemdView) -> Int { self.size }

pub fn TimeseriesdecompemdView::get(self : TimeseriesdecompemdView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesdecompemdView::set(self : TimeseriesdecompemdView, i : Int, v : Double) -> TimeseriesdecompemdView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompemdView::sum(self : TimeseriesdecompemdView) -> Double { @_common.sum(self.data) }

pub fn TimeseriesdecompemdView::mean(self : TimeseriesdecompemdView) -> Double { @_common.mean(self.data) }

pub fn TimeseriesdecompemdView::scale(self : TimeseriesdecompemdView, f : Double) -> TimeseriesdecompemdView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompemdView::add(self : TimeseriesdecompemdView, other : TimeseriesdecompemdView) -> TimeseriesdecompemdView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesdecompemdView::copy(self : TimeseriesdecompemdView) -> TimeseriesdecompemdView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompemdView::fill(self : TimeseriesdecompemdView, v : Double) -> TimeseriesdecompemdView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompemdView::min(self : TimeseriesdecompemdView) -> Double { @_common.min(self.data) }

pub fn TimeseriesdecompemdView::max(self : TimeseriesdecompemdView) -> Double { @_common.max(self.data) }

pub fn TimeseriesdecompemdView::to_string(self : TimeseriesdecompemdView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompemdRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_emd_range_make(size : Int) -> TimeseriesdecompemdRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesdecompemdRange::len(self : TimeseriesdecompemdRange) -> Int { self.size }

pub fn TimeseriesdecompemdRange::get(self : TimeseriesdecompemdRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesdecompemdRange::set(self : TimeseriesdecompemdRange, i : Int, v : Double) -> TimeseriesdecompemdRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompemdRange::sum(self : TimeseriesdecompemdRange) -> Double { @_common.sum(self.data) }

pub fn TimeseriesdecompemdRange::mean(self : TimeseriesdecompemdRange) -> Double { @_common.mean(self.data) }

pub fn TimeseriesdecompemdRange::scale(self : TimeseriesdecompemdRange, f : Double) -> TimeseriesdecompemdRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompemdRange::add(self : TimeseriesdecompemdRange, other : TimeseriesdecompemdRange) -> TimeseriesdecompemdRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesdecompemdRange::copy(self : TimeseriesdecompemdRange) -> TimeseriesdecompemdRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompemdRange::fill(self : TimeseriesdecompemdRange, v : Double) -> TimeseriesdecompemdRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompemdRange::min(self : TimeseriesdecompemdRange) -> Double { @_common.min(self.data) }

pub fn TimeseriesdecompemdRange::max(self : TimeseriesdecompemdRange) -> Double { @_common.max(self.data) }

pub fn TimeseriesdecompemdRange::to_string(self : TimeseriesdecompemdRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompemdSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_emd_slice_make(size : Int) -> TimeseriesdecompemdSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesdecompemdSlice::len(self : TimeseriesdecompemdSlice) -> Int { self.size }

pub fn TimeseriesdecompemdSlice::get(self : TimeseriesdecompemdSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesdecompemdSlice::set(self : TimeseriesdecompemdSlice, i : Int, v : Double) -> TimeseriesdecompemdSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompemdSlice::sum(self : TimeseriesdecompemdSlice) -> Double { @_common.sum(self.data) }

pub fn TimeseriesdecompemdSlice::mean(self : TimeseriesdecompemdSlice) -> Double { @_common.mean(self.data) }

pub fn TimeseriesdecompemdSlice::scale(self : TimeseriesdecompemdSlice, f : Double) -> TimeseriesdecompemdSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompemdSlice::add(self : TimeseriesdecompemdSlice, other : TimeseriesdecompemdSlice) -> TimeseriesdecompemdSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesdecompemdSlice::copy(self : TimeseriesdecompemdSlice) -> TimeseriesdecompemdSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompemdSlice::fill(self : TimeseriesdecompemdSlice, v : Double) -> TimeseriesdecompemdSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompemdSlice::min(self : TimeseriesdecompemdSlice) -> Double { @_common.min(self.data) }

pub fn TimeseriesdecompemdSlice::max(self : TimeseriesdecompemdSlice) -> Double { @_common.max(self.data) }

pub fn TimeseriesdecompemdSlice::to_string(self : TimeseriesdecompemdSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

